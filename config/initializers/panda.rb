Panda::Core.configure do |config|
  config.admin_path = "/admin"
  config.login_page_title = "Panda CMS Demo"
  config.admin_title = "Panda CMS Demo"

  config.authentication_providers = {
    github: {
      enabled: true,
      name: "GitHub",
      client_id: ENV["GITHUB_CLIENT_ID"] || Rails.application.credentials.dig(:github, :client_id),
      client_secret: ENV["GITHUB_CLIENT_SECRET"] || Rails.application.credentials.dig(:github, :client_secret),
      auto_provision: true
    }
  }
end

Panda::CMS.configure do |config|
  config.require_login_to_view = false
  config.posts = {enabled: true, prefix: "blog"}
end

if defined?(Panda::Helpdesk)
  Panda::Helpdesk.configure do |config|
    config.portal_enabled = true
    config.requester_class = "Panda::Core::User"
    config.current_user_resolver = ->(session, _request) {
      Panda::Core::User.find_by(id: session[:website_user_id])
    }
    config.sign_in_path = "/admin/login"
  end
end
