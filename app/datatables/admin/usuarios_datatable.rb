class Admin::UsuariosDatatable
    delegate :params, :h, :t, :link_to, :button_to, :content_tag, 
        :admin_usuario_path, 
        :edit_admin_usuario_path, to: :@view
  
    
    def initialize(view)
        @view = view
        @remote = params[:remote] == 'true'
    end

    def as_json(_options = {})
        {
            draw: params[:draw].to_i,
            recordsTotal: total,
            recordsFiltered: usuarios.total_count,
            data: data
        }
    end

    private 
        def data
            usuarios.each_with_index.map do |usuario, index|
                {
                    'index' => (index + 1) + ((page - 1) * per_page),
                                            
                                            
                    'nome' => column_nome(usuario),
                
                                    
                    'permissao' => column_permissao(usuario),
                
                                    
                    'email' => column_email(usuario),
                        
                    
                    'opcoes' => column_opcoes(usuario)
                }
            end
        end


                    
                    
                def column_nome(usuario)
                    
                        usuario.try(:nome)
                    
                end
            
                    
                def column_permissao(usuario)
                    
                        usuario.try(:permissao)
                    
                end
            
                    
                def column_email(usuario)
                    
                        usuario.try(:email)
                    
                end
            

        
        def column_opcoes(usuario)
            opcoes =  "<div class='sm-hero__datatable-actions'>" + (link_to(admin_usuario_path(usuario),
                    { remote: @remote, class: 'btn btn-sm btn-primary text-white me-2', title: 'Visualizar',
                    data: { toggle: 'tooltip', placement: 'top' } }) do
                    content_tag(:i, '', class: 'bi bi-search') + ' Visualizar'
            end).to_s +
            (link_to(edit_admin_usuario_path(usuario),
                        { remote: @remote, class: 'btn btn-sm btn-warning text-dark me-2', title: 'Editar',
                        data: { toggle: 'tooltip', placement: 'top' } }) do
                content_tag(:i, '', class: 'bi bi-pencil') + ' Editar'
                end).to_s +
            (button_to admin_usuario_path(usuario),
                        method: :delete,
                        data: { confirm: t('helpers.links.confirm_destroy', model: usuario.model_name.human), toggle: 'tooltip', placement: 'top' },
                        remote: @remote,
                        class: 'btn btn-sm btn-danger text-white me-2', title: 'Remover' do
                    content_tag(:i, '', class: 'bi bi-trash') + ' Remover'
                end).to_s + "</div>"

            opcoes.html_safe
        end

        def usuarios
            @usuarios ||= fetch
        end

        def query
            'Usuario'
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
            columns = ["id", "nome", "permissao", "email"]
            columns[params[:order]['0'][:column].to_i]
        end

        def sort_direction
            params[:order]['0'][:dir] == 'desc' ? 'desc' : 'asc'
        end


end