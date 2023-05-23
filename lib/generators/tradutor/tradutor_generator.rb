class TradutorGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("templates", __dir__)


  def create_tradutor_file
    template 'tradutor.pt-BR.yml', File.join('config/locales', class_path, "#{file_name}.pt-BR.yml")
  end
end
