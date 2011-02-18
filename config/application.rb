require File.expand_path('../boot', __FILE__)

require 'rails/all'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module Hdtv
  class Application < Rails::Application
    config.encoding = 'utf-8'

    config.paths.posters 'public/images/posters', :load_path => false
    config.paths.thumbnails 'public/images/thumbnails', :load_path => false
    config.paths.repos 'media/repos', :load_path => false

    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += %W(#{config.root}/lib)

    config.generators do |g|
      g.test_framework :rspec, :fixture => true, :views => false, :controllers => false
      g.fixture_replacement :factory_girl
    end

#    config.action_dispatch.x_sendfile_header = "X-Sendfile"
    config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' 

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    config.action_mailer.default_url_options = { :host => 'localhost', :port => 3000 }
    config.action_mailer.delivery_method = :sendmail
    config.action_mailer.perform_deliveries = true
    config.action_mailer.default :charset => "utf-8"

    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :ru
  end
end
