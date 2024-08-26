require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_mailbox/engine'
require 'action_text/engine'
require 'action_view/railtie'
require 'action_cable/engine'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Clinic
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.exception_app = routes

    config.i18n.available_locales = %i[en ua]
    config.i18n.default_locale = :en

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Don't generate system test files.
    config.generators.system_tests = nil
    config.action_mailer.show_previews = true

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*' # Вкажіть точний домен, з якого буде дозволено запити
        # origins 'http://127.0.0.1:5500' # Вкажіть точний домен, з якого буде дозволено запити
        resource '/watchings',
          headers: :any,
          methods: [:post],
          credentials: false # Якщо ви використовуєте куки чи інші механізми автентифікації
      end
    end
  end
end
