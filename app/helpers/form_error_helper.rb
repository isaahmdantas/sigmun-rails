module FormErrorHelper
  def error_messages(resource)
    render('shared/form_error', resource: resource)
  end
end
