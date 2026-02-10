source "https://rubygems.org"

ruby ">= 3.3.0"

gem "rails", "~> 8.1.1"
gem "pg"
gem "puma", ">= 5.0"
gem "propshaft"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"

# Panda ecosystem
gem "panda-core", github: "tastybamboo/panda-core", branch: "main"
gem "panda-editor", github: "tastybamboo/panda-editor", branch: "main"
gem "panda-cms", github: "tastybamboo/panda-cms", branch: "main"
gem "panda-cms-pro", github: "tastybamboo/panda-cms-pro", branch: "main"
gem "panda-helpdesk", github: "tastybamboo/panda-helpdesk", branch: "main"

# OAuth providers
gem "omniauth-github"
gem "omniauth-google-oauth2"

# Database-backed adapters for cache, jobs, and cable
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

# Image processing for Active Storage variants
gem "image_processing", "~> 1.2"

# Windows timezone data
gem "tzinfo-data", platforms: %i[windows jruby]

# Faster boot
gem "bootsnap", require: false

# Deployment
gem "kamal", require: false
gem "thruster", require: false

group :production do
  gem "rack-attack"
end

group :development do
  gem "web-console"
end
