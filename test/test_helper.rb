ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require(:test)

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'capybara'

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

module PayloadPrep

  def setup_model_testing_environment
    TrafficSpy::RegistrationParser.new({"rootUrl"=>"http://jumpstartlab.com", "identifier"=>"jumpstartlab"}).parsing_validating

    TrafficSpy::PayloadParser.new(payload_params1).payload_response
    TrafficSpy::PayloadParser.new(payload_params2).payload_response
    TrafficSpy::PayloadParser.new(payload_params3).payload_response
  end

  def register_user
    parser_setup({"rootUrl"=>"http://jumpstartlab.com", "identifier"=>"jumpstartlab"}).parsing_validating
  end

  def parser_setup(params)
    @parser = TrafficSpy::RegistrationParser.new(params)
  end

  def payload_params1
    {"payload"=>
      "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":39,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
     "splat"=>[],
     "captures"=>["jumpstartlab"],
     "id"=>"jumpstartlab"}
  end

  def payload_params2
    {"payload"=>
      "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:39:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
     "splat"=>[],
     "captures"=>["jumpstartlab"],
     "id"=>"jumpstartlab"}
  end

  def payload_params3
    {"payload"=>
      "{\"url\":\"http://jumpstartlab.com/weather\",\"requestedAt\":\"2013-02-16 20:38:28 -0700\",\"respondedIn\":39,\"referredBy\":\"http://google.com\",\"requestType\":\"POST\",\"parameters\":[1],\"eventName\":\"registrationInformation\",\"userAgent\":\"Mozilla/5.0 (Windows-RSS-Platform/2.0 (IE 11.0; Windows NT 6.1)) AppleWebKit/537.75.14 (KHTML, like Gecko) Version/7.0.3 Safari/7046A194A\",\"resolutionWidth\":\"12\",\"resolutionHeight\":\"120\",\"ip\":\"63.29.38.210\"}",
     "splat"=>[],
     "captures"=>["jumpstartlab"],
     "id"=>"jumpstartlab"}
  end
end
