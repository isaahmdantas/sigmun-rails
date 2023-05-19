<% if namespaced? -%>
    require_dependency "<%= namespaced_path %>/application_controller"
    
    <% end -%>
    <% module_namespacing do -%>
    class <%= controller_class_name %>Controller < ApplicationController
        layout 'cruds'
      
        before_action :set_<%= singular_table_name %>, only: %i[show edit update destroy]
        # load_and_authorize_resource
      
        # GET <%= route_url %>
        def index
          unless request.format.in?(['html', 'js'])
            @<%= plural_table_name %> = <%= orm_class.all(class_name) %>
          else
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
                    location = [@<%= singular_table_name %>]
                    location.unshift(params[:controller].split("/")[0].to_sym) if params[:controller].split("/").length > 1
                    format.html { redirect_to location, notice: notice}
                    format.json { render :show, status: :created, location: @<%= singular_table_name %> }
                    format.js { flash[:notice] = notice}
                else
                    format.html { render :new }
                    format.json { render json: @<%= singular_table_name %>.errors, status: :unprocessable_entity }
                    format.js { render :new }
                end
            end
        end
      
        # PATCH/PUT <%= route_url %>/1
        def update
            notice = <%= "'#{human_name} alterado(a) com sucesso.'" %>
            respond_to do |format|
                if @<%= orm_instance.update("#{singular_table_name}_params") %>
                    location = [@<%= singular_table_name %>]
                    location.unshift(params[:controller].split("/")[0].to_sym) if params[:controller].split("/").length > 1
                    format.html { redirect_to location, notice: notice }
                    format.json { render :show, status: :ok, location: location }
                    format.js { flash[:notice] = notice}
                else
                    format.html { render :edit }
                    format.json { render json: @<%= singular_table_name %>.errors, status: :unprocessable_entity }
                    format.js { render :edit }
                end
            end
        end
      
        # DELETE <%= route_url %>/1
        def destroy
            notice = <%= "'#{human_name} removido(a) com sucesso.'" %>
            respond_to do |format|
                if  @<%= orm_instance.destroy %>
                    format.html { redirect_to params[:controller].split("/").map(&:to_sym), notice: notice }
                    format.json { head :no_content }
                    format.js { flash[:notice] = notice}
                else 
                    format.html { render :edit }
                    format.json { render json: @<%= singular_table_name %>.errors, status: :unprocessable_entity }
                    format.js { render :edit }
                end
            end
        end
        
        # POST <%= route_url %>/datatable
        def datatable
          respond_to do |format|
            format.json { render json: <%= controller_class_name %>Datatable.new(view_context) }
          end
        end
        
        # GET <%= route_url %>/datatable
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
    