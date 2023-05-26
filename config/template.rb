apply "config/application.rb"

copy_file "config/sidekiq.yml"

gsub_file "config/routes.rb", /  # root 'welcome#index'/ do
  '  root "home#index"'
end

copy_file "config/initializers/date_time_formats.rb"
copy_file "config/initializers/rack_attack.rb"
copy_file "config/initializers/field_error_proc.rb"
copy_file "config/initializers/routes_exceptions.rb"
copy_file "config/initializers/sidekiq.rb"

directory "config/locales", force: true


apply "config/environments/development.rb"
apply "config/environments/test.rb"

route 'root "home#index"'
route 'RESPOND_404.map { |r2|  get "/#{r2}", to: redirect("/404") } '

route "get 'listagem', to: 'home#listagem'"
route "get 'create', to: 'home#create'"




