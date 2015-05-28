ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara'
require 'database_cleaner'
require 'tilt/erb'
require 'byebug'

DatabaseCleaner.strategy = :truncation, {except: %w[public.schema_migrations]}

Capybara.app = TrafficSpy::Server

class ControllersTest < Minitest::Test
  include Rack::Test::Methods

  def app     # def app is something that Rack::Test is looking for
    TrafficSpy::Server
  end

  def setup
    DatabaseCleaner.start #move these two methods to test helper
  end

  def teardown
    DatabaseCleaner.clean
  end
end
