ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require(:test)

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'capybara'
require_relative 'payloadprep'

DatabaseCleaner.strategy = :truncation, {except: %w[public.schema_migrations]}

Capybara.app = TrafficSpy::Server

class TrafficTest < Minitest::Test
  include Rack::Test::Methods     # allows us to use get, post, last_request, etc

  def app    #app is a reserved word that should return name of sinatra app
    TrafficSpy::Server
  end

  def setup      #should usually put these methods in the test helper file
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end
end

class FeatureTest < TrafficTest
  include Capybara::DSL
end
