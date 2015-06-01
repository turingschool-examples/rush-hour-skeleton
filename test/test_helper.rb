require 'simplecov'
SimpleCov.start
ENV["RACK_ENV"] ||= "test"


require 'bundler'
require 'tilt/erb'
require 'byebug'
require 'minitest/pride'

Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'capybara'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation, {except: %w[public.schema_migrations]}

Capybara.app = TrafficSpy::Server

class ControllerTest < Minitest::Test
  include Rack::Test::Methods     # allows us to use get, post, last_request, etc.

  def app     # def app is something that Rack::Test is looking for
    TrafficSpy::Server
  end

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

end

class FeatureTest < ControllerTest
  include Capybara::DSL
end

