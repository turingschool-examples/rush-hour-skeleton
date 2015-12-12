ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara'
require 'database_cleaner'
require 'tilt/erb'
require_relative '../test/simulation_environment/client_environment_simulator'

DatabaseCleaner.strategy = :truncation, { except: %w[public.schema_migrations] }

Capybara.app = TrafficSpy::Server

class Minitest::Test

  include Rack::Test::Methods

  def app
    TrafficSpy::Server
  end

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

end

class FeatureTest < Minitest::Test
  include Capybara::DSL
end
