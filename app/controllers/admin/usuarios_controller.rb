class Admin::UsuariosController < AdminController
    before_action :set_usuario, only: [:show, :edit, :update, :destroy]

    # GET /usuarios
    def index
        unless request.format.in?(['html', 'js'])
            @usuarios = Usuario.all
        end
        respond_to do |format|
            format.html
            format.json
            format.js
        end
    end

    # GET /usuarios/1
    def show;end

    # GET /usuarios/new
    def new
        @usuario = Usuario.new(usuario_params)
    end

    # GET /usuarios/1/edit
    def edit;end

    # POST /usuarios
    def create
        @usuario = Usuario.new(usuario_params)
        notice = 'Usuario cadastrado(a) com sucesso.'
        respond_to do |format|
            if @usuario.save
                remote = params.try(:[], :remote)
                location = [@usuario]
                location.unshift(params[:controller].split("/")[0].to_sym) if params[:controller].split("/").length > 1
                format.html { redirect_to remote.blank? ? location : admin_usuarios_path, notice: notice}
                format.json { render :show, status: :created, location: @usuario }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @usuario.errors, status: :unprocessable_entity }
                format.turbo_stream { render :form_update, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /usuarios/1
    def update
        notice = 'Usuario alterado(a) com sucesso.'
        respond_to do |format|
            if @usuario.update(usuario_params)
                remote = params.try(:[], :remote)
                location = [@usuario]
                location.unshift(params[:controller].split("/")[0].to_sym) if params[:controller].split("/").length > 1
                format.html { redirect_to remote.blank? ? location : admin_usuarios_path, notice: notice}
                format.json { render :show, status: :ok, location: location }
                format.js { flash[:notice] = notice}
            else
                format.html { render :edit, status: :unprocessable_entity  }
                format.json { render json: @usuario.errors, status: :unprocessable_entity }
                format.turbo_stream { render :form_update, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /usuarios/1
    def destroy
        @usuario.destroy
        notice = 'Usuario removido(a) com sucesso.'
        respond_to do |format|
            format.html { redirect_to params[:controller].split("/").map(&:to_sym), notice: notice }
            format.json { head :no_content }
            format.js { render partial: 'shared/errors', locals: {errors: @usuario.errors} }
        end
    end

    def datatable
        respond_to do |format|
            format.json { render json: Admin::UsuariosDatatable.new(view_context) }
        end
    end

    def search
        respond_to do |format|
            format.json { render json: Usuario.search(params[:search])  }
        end
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_usuario
            @usuario = Usuario.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def usuario_params
            if params[:usuario]
                    params.require(:usuario).permit(:nome, :permissao, :email, :password)
            end
        end


end
    