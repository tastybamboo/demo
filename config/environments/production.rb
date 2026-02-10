require "active_support/core_ext/integer/time"

Rails.application.configure do
  config.enable_reloading = false
  config.eager_load = true
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true

  # Cache assets for far-future expiry since they are all digest stamped.
  config.public_file_server.headers = {"cache-control" => "public, max-age=#{1.year.to_i}"}

  # Active Storage: use DO Spaces in production if configured, otherwise local disk
  config.active_storage.service = ENV["SPACES_ACCESS_KEY_ID"].present? ? :digitalocean : :local

  # SSL
  config.assume_ssl = true
  config.force_ssl = true
  config.ssl_options = {redirect: {exclude: ->(request) { request.path == "/up" }}}

  # Logging
  config.log_tags = [:request_id]
  config.logger = ActiveSupport::TaggedLogging.logger(STDOUT)
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")
  config.silence_healthcheck_path = "/up"
  config.active_support.report_deprecations = false

  # Solid Cache / Queue / Cable
  config.cache_store = :solid_cache_store
  config.active_job.queue_adapter = :solid_queue
  config.solid_queue.connects_to = {database: {writing: :queue}}

  # Mailer
  config.action_mailer.default_url_options = {host: ENV.fetch("APP_HOST", "demo.tastybamboo.io")}
  config.action_mailer.perform_deliveries = ENV["SMTP_ADDRESS"].present?
  if ENV["SMTP_ADDRESS"].present?
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address: ENV["SMTP_ADDRESS"],
      port: ENV.fetch("SMTP_PORT", 587).to_i,
      user_name: ENV["SMTP_USERNAME"],
      password: ENV["SMTP_PASSWORD"],
      authentication: :plain,
      enable_starttls_auto: true
    }
  end

  # I18n
  config.i18n.fallbacks = true

  # DB
  config.active_record.dump_schema_after_migration = false
  config.active_record.attributes_for_inspect = [:id]

  # Host authorization
  config.hosts = [
    "demo.tastybamboo.io",
    /.*\.ondigitalocean\.app/
  ]
  config.host_authorization = {exclude: ->(request) { request.path == "/up" }}
end
