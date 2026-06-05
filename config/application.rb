require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Blog
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    config.autoloader = :classic

    config.i18n.available_locales = [:en, :vi]

    config.i18n.default_locale = :en

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    load_paths = [Rails.root.join("lib/redis"), Rails.root.join("lib/feeds"),
                  Rails.root.join("lib/error"), Rails.root.join("lib/colorable")]

    config.autoload_paths += load_paths
    config.eager_load_paths += load_paths
  end
end
