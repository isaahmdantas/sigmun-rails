class ErrorsController < ApplicationController
  layout 'erro'
  
  def not_found
    respond_to do |format|
      format.html { render status: 404 }
      format.all { redirect_to '/404' }
    end
  end
  
  def unacceptable
    respond_to do |format|
      format.html { render status: 422 }
      format.all { redirect_to '/422' }
    end
  end
  
  def internal_server_error
    respond_to do |format|
      format.html { render status: 500 }
      format.all { redirect_to '/500' }
    end
  end
end