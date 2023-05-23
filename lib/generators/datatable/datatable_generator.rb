class DatatableGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("templates", __dir__)


  def create_datatable_file
    template 'datatable.rb', File.join('app/datatables', class_path, "#{file_name}_datatable.rb")
  end
end
