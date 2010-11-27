require File.expand_path('../boot', __FILE__)

require 'rails/all'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module Hdtv
  class Application < Rails::Application
    config.paths.posters 'public/images/posters', :load_path => false
    config.paths.repos 'media/repos', :load_path => false

    config.generators do |g|
      g.test_framework :rspec, :fixture => true, :views => false, :controllers => false
      g.fixture_replacement :factory_girl
    end

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]
  end
end
