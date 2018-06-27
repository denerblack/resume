require_relative 'boot'

require 'rails/all'
#require 'mongoid'
require "action_controller/railtie"
require "action_mailer/railtie"
# require "active_resource/railtie"
require "sprockets/railtie"
require 'action_cable/engine'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Resume
  class Application < Rails::Application
    #   I18n.load_path += Dir[Rails.root.join('lib', 'locale', '*.{rb,yml}')]
    # Set default locale to something other than :en
    config.i18n.default_locale = "pt-BR"
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.generators do |g|
      g.orm :mongoid
    end
  end
end
