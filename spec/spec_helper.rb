# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'paperclip/matchers'
require 'remarkable/active_record'
require 'remarkable/devise'
require 'remarkable/devise/invitable'
require 'database_cleaner'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

# Requires factories
Dir[Rails.root.join("spec/factories/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.include Paperclip::Shoulda::Matchers

  config.include Devise::TestHelpers, :type => :controller
  
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :mocha

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  # config.fixture_path = "#{::Rails.root}/spec/factories"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  # config.use_transactional_fixtures = true

  config.after(:each, :type => :model) do
    cleanup_dirs = [REPOS_PATH, POSTERS_PATH, THUMBNAILS_PATH]

    cleanup_dirs.each do |dir_path|
      FileUtils.rm_r(dir_path) if File.exists?(dir_path)
    end
  end

  config.before(:suite) do
    DatabaseCleaner.orm = :mongoid
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
