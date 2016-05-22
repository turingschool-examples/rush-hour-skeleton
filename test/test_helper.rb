ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation, {except: %[public.schema_migrations]}
Capybara.app = RushHourApp

module TestHelpers
  include Rack::Test::Methods
  def app     # def app is something that Rack::Test is looking for
    RushHourApp
  end

  def setup
    DatabaseCleaner.start
    super
  end

  def teardown
    DatabaseCleaner.clean
    super
  end
end
