require "fileutils"
require "shellwords"
require "bundler"
require "json"

RAILS_REQUIREMENT = "~> 7.0.0".freeze

# Aplicar o template no projeto rails 
def apply_template!
    assert_minimum_rails_version
    assert_valid_options
    assert_postgresql
    add_template_repository_to_source_path

    template "Gemfile.tt", force: true 
    template "README.md.tt", force: true

    template "config/application.yml.tt"

    copy_file "editorconfig", ".editorconfig"

    template "node-version.tt", ".node-version", force: true
    template "ruby-version.tt", ".ruby-version", force: true

    copy_file "Procfile"
    copy_file "package.json"

    apply "bin/template.rb"
    apply "config/template.rb"
    apply "lib/template.rb"

    after_bundle do
      append_to_file ".gitignore", <<~IGNORE
        /config/application.yml
        
        /vendor/bundle/
        /public/assets
        /app/assets/builds/*
        !/app/assets/builds/.keep
        /node_modules
        
        .ruby-version
        .node-version 
        .ruby-gemset

        # OS generated files #
        .DS_Store
        .DS_Store?
        ._*
        .Spotlight-V100
        .Trashes
        ehthumbs.db
        Thumbs.db

      IGNORE

      apply "app/template.rb"

      run_with_clean_bundler_env "bundle lock --add-platform x86_64-linux"

      unless any_local_git_commits?
        git :init
        git checkout: "-b main"
        git add: "-A ."
        git commit: "-n -m 'Configuração do projeto'"


        say
        say "Aplicativo #{app_name} criado com sucesso!", :blue
        say
        say "Para começar a usar seu novo aplicativo:", :green
        say "cd #{app_name} - Alterne para o diretório do seu novo aplicativo."
      end

    end
end


# Verificar a versão do rails que está sendo executado
def assert_minimum_rails_version
    requirement = Gem::Requirement.new(RAILS_REQUIREMENT)
    rails_version = Gem::Version.new(Rails::VERSION::STRING)
    return if requirement.satisfied_by?(rails_version)
  
    prompt = "Este template requer o rails -v #{RAILS_REQUIREMENT}. "\
        "Você está usando rails -v #{rails_version}. Continuar de qualquer maneira ?"
    exit 1 if no?(prompt)
end

# Verificar se não foi passado nenhuma opção contraditória dos geradores do rails
def assert_valid_options
    valid_options = {
      skip_gemfile: false,
      skip_bundle: false,
      skip_git: false,
      skip_system_test: false,
      skip_test: false,
      skip_test_unit: false,
      edge: false
    }
    valid_options.each do |key, expected|
        next unless options.key?(key)
        actual = options[key]
        unless actual == expected
            fail Rails::Generators::Error, "Opção não suportada: #{key}=#{actual}"
        end
    end
end

# Verificar se está sendo utilizado o banco de dados postgresql
def assert_postgresql
    return if IO.read("Gemfile") =~ /^\s*gem ['"]pg['"]/
    fail Rails::Generators::Error, "Este template requer PostgreSQL, mas a gem 'pg' não está presente em seu Gemfile."
end

# Adiciona o repositório nos arquivos de geração da aplicação
def add_template_repository_to_source_path
    if __FILE__ =~ %r{\Ahttps?://}
      require "tmpdir"
      source_paths.unshift(tempdir = Dir.mktmpdir("rails-swift-"))
      at_exit { FileUtils.remove_entry(tempdir) }
      git clone: [
        "--quiet",
        "https://isaahmdantas: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@github.com/isaahmdantas/rails-swift.git",
        tempdir
      ].map(&:shellescape).join(" ")
  
      if (branch = __FILE__[%r{rails-swift/(.+)/template.rb}, 1])
        Dir.chdir(tempdir) { git checkout: branch }
      end
    else
      source_paths.unshift(File.dirname(__FILE__))
    end
end

def any_local_git_commits?
  system("git log > /dev/null 2>&1")
end


# Executar todo o template no novo projeto
apply_template!