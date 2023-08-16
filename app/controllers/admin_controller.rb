# Renders the admin page.
class AdminController < ActionController::Base    
    protect_from_forgery prepend: true, with: :exception
    protect_from_forgery prepend: true, with: :null_session, if: proc { |c| c.request.format == 'application/json' }  

    after_action :flash_to_headers
    before_action :authenticate_usuario!

    helper_method :current_user 

    rescue_from CanCan::AccessDenied do |exception|
        respond_to do |format|
        format.json { head :forbidden, content_type: 'text/html' }
        format.html { redirect_to admin_url, alert: exception.message }
        format.js   { render partial: 'shared/errors', locals: {error: exception.message} }
        end
    end

    def index;end

    def flash_to_headers
        return unless request.xhr?
        response.headers['X-Message'] = flash_message
        response.headers["X-Message-Type"] = flash_type.to_s
        flash.discard # don't want the flash to appear when you reload page
    end

    protected
        def current_user
            current_usuario 
        end

    private
        def flash_message
            [:error, :warning, :notice].each do |type|
                return flash[type] unless flash[type].blank?
            end
        end

        def flash_type
            [:error, :warning, :notice].each do |type|
                return type unless flash[type].blank?
            end
        end
end
