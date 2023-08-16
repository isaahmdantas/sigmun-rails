apply "config/application.rb"

copy_file "config/sidekiq.yml"

gsub_file "config/routes.rb", /  # root 'welcome#index'/ do
  '  root "site#index"'
end

copy_file "config/initializers/date_time_formats.rb"
copy_file "config/initializers/rack_attack.rb"
copy_file "config/initializers/field_error_proc.rb"
copy_file "config/initializers/routes_exceptions.rb"
copy_file "config/initializers/sidekiq.rb"
copy_file "config/initializers/devise.rb"
copy_file 'config/initializers/assets.rb', force: true
copy_file 'config/initializers/inflections.rb', force: true

directory "config/locales", force: true


apply "config/environments/development.rb"
apply "config/environments/test.rb"

route 'root "site#index"'
route 'RESPOND_404.map { |r2|  get "/#{r2}", to: redirect("/404") } '

# rotas da Área Administrativa
route 'get "admin", controller: :admin, action: :index, as: :admin_root'


