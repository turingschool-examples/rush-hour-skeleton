ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara'
require 'database_cleaner'
require 'tilt/erb'

Capybara.app = TrafficSpy::Server
DatabaseCleaner.strategy = :truncation, {except: %w[public.schema_migrations]}

class Minitest::Test
  include Rack::Test::Methods

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

  def app
    TrafficSpy::Server
  end
end

class FeatureTest < Minitest::Test
  include Capybara::DSL
end
