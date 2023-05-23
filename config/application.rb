insert_into_file "config/application.rb", <<-RUBY, before: "  end"

    config.time_zone = ActiveSupport::TimeZone.new('America/Recife')
    config.i18n.default_locale = :'pt-BR'
    config.exceptions_app = self.routes
    config.active_record.yaml_column_permitted_classes = [Symbol, Hash, Array, Date, DateTime, Time, BigDecimal, ActiveSupport::HashWithIndifferentAccess, ActiveSupport::TimeZone, ActiveSupport::TimeWithZone]


    config.generators do |g|
        g.orm :active_record, primary_key_type: :uuid
        g.test_framework :rspec
    end
RUBY