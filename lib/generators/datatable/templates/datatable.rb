class <%= class_name %>Datatable
    delegate :params, :h, :t, :link_to, :button_to, :content_tag, 
        :<%= singular_table_name %>_path, 
        :edit_<%= singular_table_name %>_path, to: :@view
  
    
    def initialize(view)
        @view = view
        @remote = params[:remote] == 'true'
    end

    def as_json(_options = {})
        {
            draw: params[:draw].to_i,
            recordsTotal: total,
            recordsFiltered: <%= plural_table_name %>.total_count,
            data: data
        }
    end

    private 
        def data
            <%= plural_table_name %>.each_with_index.map do |<%= singular_table_name %>, index|
                {
                    'index' => (index + 1) + ((page - 1) * per_page),
                    <% singular_table_name.capitalize.constantize.attribute_names.each do |attribute|  -%>
                        <% if attribute != 'deleted_at' && attribute != 'id' %>
                            '<%= attribute %>' => column_<%= attribute %>(<%= singular_table_name %>),
                        <% end  %>
                    <% end %>
                    'opcoes' => column_opcoes(<%= singular_table_name %>)
                }
            end
        end


        <% singular_table_name.capitalize.constantize.attribute_names.each do |attribute|  -%>
            <% if attribute != 'deleted_at' && attribute != 'id' %>
                def column_<%= attribute %>(<%= singular_table_name %>)
                    <% if attribute == 'created_at' || attribute == 'updated_at' %>
                        <%= singular_table_name %>.try(:<%= attribute %>).try(:to_fs)
                    <% else %>
                        <%= singular_table_name %>.try(:<%= attribute %>)
                    <% end %>
                end
            <% end %>
        <% end %>

        
        def column_opcoes(<%= singular_table_name %>)
            opcoes =  "<div class='sm-hero__datatable-actions'>" + (link_to(<%= singular_table_name %>_path(<%= singular_table_name %>),
                    { remote: @remote, class: 'btn btn-sm btn-primary text-white me-2', title: 'Visualizar',
                    data: { toggle: 'tooltip', placement: 'top' } }) do
                    content_tag(:i, '', class: 'bi bi-search') + ' Visualizar'
            end).to_s +
            (link_to(edit_<%= singular_table_name %>_path(<%= singular_table_name %>),
                        { remote: @remote, class: 'btn btn-sm btn-warning text-dark me-2', title: 'Editar',
                        data: { toggle: 'tooltip', placement: 'top' } }) do
                content_tag(:i, '', class: 'bi bi-pencil') + ' Editar'
                end).to_s +
            (button_to <%= singular_table_name %>_path(<%= singular_table_name %>),
                        method: :delete,
                        data: { confirm: t('helpers.links.confirm_destroy', model: <%= singular_table_name %>.model_name.human), toggle: 'tooltip', placement: 'top' },
                        remote: @remote,
                        class: 'btn btn-sm btn-danger text-white me-2', title: 'Remover' do
                    content_tag(:i, '', class: 'bi bi-trash') + ' Remover'
                end).to_s + "</div>"

            opcoes.html_safe
        end

        def <%= plural_table_name %>
            @<%= plural_table_name %> ||= fetch
        end

        def query
            '<%= singular_table_name.capitalize %>'
        end

        def fetch
            str_query = query
            params[:columns].each do |column|
                str_query << ".where(#{column[1][:data]}: '#{column[1][:search][:value]}')" if column[1][:search][:value].present?
            end
            str_query << '.search(params[:search][:value])' if params[:search][:value].present?
            str_query << %{.order("#{sort_column}" => "#{sort_direction}").page(page).per(per_page)}
            eval str_query
        end

        def total
            str_query = query
            str_query << '.count'
            eval str_query
        end

        def page
            params[:start].to_i / per_page + 1
        end
    
        def per_page
            params[:length].to_i.positive? ? params[:length].to_i : 10
        end
    
        def sort_column
            columns = <%= singular_table_name.capitalize.constantize.attribute_names.reject{|e| e == 'deleted_at' } %>
            columns[params[:order]['0'][:column].to_i]
        end

        def sort_direction
            params[:order]['0'][:dir] == 'desc' ? 'desc' : 'asc'
        end


end