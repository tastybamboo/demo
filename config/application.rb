require_relative "boot"

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"

Bundler.require(*Rails.groups)

require "panda/core"
require "panda/cms"

begin
  require "panda-cms-pro"
rescue LoadError
  # panda-cms-pro is optional
end

begin
  require "panda/helpdesk"
rescue LoadError
  # panda-helpdesk is optional
end

module Demo
  class Application < Rails::Application
    config.load_defaults 8.1
    config.autoload_lib(ignore: %w[assets tasks])
    config.time_zone = "Europe/London"
    config.generators.system_tests = nil
  end
end
