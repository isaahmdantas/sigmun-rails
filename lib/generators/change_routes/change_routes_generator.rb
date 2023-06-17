class ChangeRoutesGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("templates", __dir__)


  def change_route 
    gsub_file('config/routes.rb', /resources :#{plural_table_name}$/, "resources :#{plural_table_name} do\n    collection do\n   get 'search'\n  post 'datatable'\n  end\nend")
  end
end





