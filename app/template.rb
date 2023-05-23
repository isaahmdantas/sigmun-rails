apply "app/assets/template.rb"

copy_file "app/controllers/home_controller.rb"
copy_file "app/controllers/errors_controller.rb"
copy_file "app/controllers/audits_controller.rb"



copy_file "app/helpers/layout_helper.rb"
copy_file "app/helpers/form_error_helper.rb"


insert_into_file "app/controllers/application_controller.rb", after: /^class ApplicationController.*\n/ do
    <<-RUBY
    protect_from_forgery prepend: true, with: :exception
    protect_from_forgery prepend: true, with: :null_session, if: proc { |c| c.request.format == 'application/json' }  
    RUBY
end


route "match '404', :to => 'errors#not_found', :via => :all"
route "match '422', :to => 'errors#unacceptable', :via => :all"
route "match '500', :to => 'errors#internal_server_error', :via => :all"

route "match '/audits/show', controller: 'audits', action: 'show', via: [:get]"

directory "app/views/layouts/partials", force: true
directory "app/views/shared", force: true
directory "app/views/errors", force: true
directory "app/views/audits", force: true

copy_file "app/views/layouts/application.html.erb", force: true
copy_file "app/views/layouts/mailer.html.erb", force: true
template "app/views/home/<%= root_path %>.erb.tt"

copy_file "app/views/layouts/erro.html.erb"