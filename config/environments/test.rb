insert_into_file "config/environments/test.rb", after: /config\.action_mailer\.delivery_method = :test\n/ do
    <<-RUBY
  
    # Ensure mailer works in test
    config.action_mailer.default_url_options = { host: "localhost:3000" }
    config.action_mailer.asset_host = "http://localhost:3000"
    RUBY
end
  