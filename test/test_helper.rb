ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation, {except: %w[public.schema_migrations]}

Capybara.app = TrafficSpy::Server


class ControllerTest < Minitest::Test
  def app
    TrafficSpy::Server
  end
end

class Minitest::Test
  include Rack::Test::Methods

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

class URLPageTest < FeatureTest
  def create_data
    Source.create({identifier: "jumpstartlab", root_url: "http://jumpstartlab.com" })
    Payload.create({source_id: 1, url: "http://jumpstartlab.com/blog", requested_at: "2013-02-16 21:38:28 -0701", responded_in: 10, request_type: "GET"})
  end
end
