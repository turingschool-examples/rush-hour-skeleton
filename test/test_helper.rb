ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require(:test)

DatabaseCleaner.strategy = :truncation, {except: %w[public.schema_migrations]}

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'capybara'

Capybara.app = TrafficSpy::Server

def TrafficTest < Minitest::Test
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
