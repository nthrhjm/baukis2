require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you"ve limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Baukis2
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    config.time_zone = "Tokyo"
    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.{rb,yml}").to_s]
    config.i18n.default_locale = :ja

    config.generators do |g|
      g.skip_routes true #true: routes.rbを変更しない
      g.helper false
      g.assets false #css,Javascriptファイルを自動生成しない
      g.test_framework :rspec #test frameworkを指定
      g.controller_specs false #controller specを自動生成しない
      g.view_specs false #view specを自動生成しない
    end
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
