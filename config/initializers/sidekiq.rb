return unless defined?(Sidekiq)

Sidekiq.configure_server do |config|
    config.error_handlers << proc {|ex,ctx_hash| ExceptionNotifier.notify_exception(ex) }
end