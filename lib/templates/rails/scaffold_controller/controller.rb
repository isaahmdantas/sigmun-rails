<% if namespaced? -%>
    require_dependency "<%= namespaced_path %>/application_controller"
    
<% end -%>
<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ApplicationController
    before_action :set_<%= singular_table_name %>, only: [:show, :edit, :update, :destroy]

    # GET <%= route_url %>
    def index
        unless request.format.in?(['html', 'js'])
            @<%= plural_table_name %> = <%= orm_class.all(class_name) %>
        end
        respond_to do |format|
            format.html
            format.json
            format.js
        end
    end

    # GET <%= route_url %>/1
    def show;end

    # GET <%= route_url %>/new
    def new
        @<%= singular_table_name %> = <%= orm_class.build(class_name, "#{singular_table_name}_params") %>
    end

    # GET <%= route_url %>/1/edit
    def edit;end

    # POST <%= route_url %>
    def create
        @<%= singular_table_name %> = <%= orm_class.build(class_name, "#{singular_table_name}_params") %>
        notice = <%= "'#{human_name} cadastrado(a) com sucesso.'" %>
        respond_to do |format|
            if @<%= orm_instance.save %>
                remote = params.try(:[], :remote)
                location = [@<%= singular_table_name %>]
                location.unshift(params[:controller].split("/")[0].to_sym) if params[:controller].split("/").length > 1
                format.html { redirect_to remote.blank? ? location : <%= plural_table_name %>_path, notice: notice}
                format.json { render :show, status: :created, location: @<%= singular_table_name %> }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @<%= singular_table_name %>.errors, status: :unprocessable_entity }
                format.turbo_stream { render :form_update, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT <%= route_url %>/1
    def update
        notice = <%= "'#{human_name} alterado(a) com sucesso.'" %>
        respond_to do |format|
            if @<%= orm_instance.update("#{singular_table_name}_params") %>
                remote = params.try(:[], :remote)
                location = [@<%= singular_table_name %>]
                location.unshift(params[:controller].split("/")[0].to_sym) if params[:controller].split("/").length > 1
                format.html { redirect_to remote.blank? ? location : <%= plural_table_name %>_path, notice: notice}
                format.json { render :show, status: :ok, location: location }
                format.js { flash[:notice] = notice}
            else
                format.html { render :edit, status: :unprocessable_entity  }
                format.json { render json: @<%= singular_table_name %>.errors, status: :unprocessable_entity }
                format.turbo_stream { render :form_update, status: :unprocessable_entity }
            end
        end
    end

    # DELETE <%= route_url %>/1
    def destroy
        @<%= orm_instance.destroy %>
        notice = <%= "'#{human_name} removido(a) com sucesso.'" %>
        respond_to do |format|
            format.html { redirect_to params[:controller].split("/").map(&:to_sym), notice: notice }
            format.json { head :no_content }
            format.js { render partial: 'shared/errors', locals: {errors: @<%= singular_table_name %>.errors} }
        end
    end

    def datatable
        respond_to do |format|
            format.json { render json: <%= controller_class_name %>Datatable.new(view_context) }
        end
    end

    def search
        respond_to do |format|
            format.json { render json: <%= singular_table_name.capitalize %>.search(params[:search])  }
        end
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_<%= singular_table_name %>
            @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def <%= "#{singular_table_name}_params" %>
            if <%= "params[:#{singular_table_name}]" %>
                <%- if attributes_names.empty? -%>
                    params.fetch(:<%= singular_table_name %>, {})
                <%- else -%>
                    params.require(:<%= singular_table_name %>).permit(<%= attributes_names.map { |name| ":#{name}" }.join(', ') %>)
                <%- end -%>
            end
        end


end
<% end -%>
    