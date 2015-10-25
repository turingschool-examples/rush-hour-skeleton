require 'simplecov'
SimpleCov.start

ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara'
require 'pry'

DatabaseCleaner.strategy = :truncation, {except: %w[public.schema_migrations]}

class Minitest::Test

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end
end

class ControllerTest < Minitest::Test
  include Rack::Test::Methods

  def app
    TrafficSpy::Server
  end
end

Capybara.app = TrafficSpy::Server

class FeatureTest < Minitest::Test
  include Capybara::DSL
  include Rack::Test::Methods

  def app
    TrafficSpy::Server
  end

  def identifier
    post '/sources', { identifier:  "jumpstartlab",
                       rootUrl:     "http://jumpstartlab.com" }
  end

  def payload_data
     {"payload" => {"url":"http://jumpstartlab.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":37,
      "referredBy":"http://jumpstartlab.com",
      "requestType":"GET",
      "parameters":[],
      "eventName":"socialLogin",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"63.29.38.211" }.to_json }
  end

  def payload_data_two
     {"payload" => {"url":"http://jumpstartlab.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":666,
      "referredBy":"http://jumpstartlab.com",
      "requestType":"GET",
      "parameters":[],
      "eventName":"die with your boots on",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"63.29.38.211" }.to_json }
  end
end
