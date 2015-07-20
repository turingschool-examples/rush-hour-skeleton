ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara'
require 'pry'
require 'tilt/erb'


require 'database_cleaner'
DatabaseCleaner.strategy = :truncation, { except: %w[public.schema_migrations] }


class Minitest::Test

  def setup
    DatabaseCleaner.start

    @raw_payload = { "payload"    => "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\": \"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
                     "splat"      => [],
                     "captures"   => ["jumpstartlab"],
                     "identifier" => "jumpstartlab" }
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

  private

  def register(identifier)
    RegistrationHandler.new({ 'identifier' => identifier, 'rootUrl' => 'http://facebook.com' })
  end

  private

  def create_events(name, how_many)
    (1..how_many).each do
      event_payload = return_event_with_name(name)
      create_event(event_payload)
    end
  end

  def create_event(event_payload)
    DataProcessingHandler.new(return_unique_payload(event_payload), @identifier)
  end

  def return_event_with_name(name)
    payload            = {}
    payload['payload'] = @raw_payload['payload'].sub('socialLogin', name)
    payload
  end

  def return_event_on_hour(hour, name)
    return nil if hour < 0 || hour > 24
    payload            = return_event_with_name(name)
    payload['payload'] = payload['payload'].sub('2013-02-16 21:38:28 -0700', "2013-02-16 #{hour}:00:00")
    payload
  end

  def return_unique_payload(original_payload)
    # Couldn't figure out how to make a static counter for the test class so just used random for now
    original_payload['payload'] = original_payload['payload'].sub('1920', Random.new().rand(9999).to_s)
    original_payload
  end

end
