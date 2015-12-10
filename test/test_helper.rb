ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require(:test)

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'tilt/haml'
require 'capybara'

DatabaseCleaner.strategy = :truncation, {except: %w[public.schema_migrations]}

Capybara.app = TrafficSpy::Server

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

class ModelTest < Minitest::Test
end

class FeatureTest < Minitest::Test
  include Capybara::DSL

  def register_turing_and_send_multiple_payloads
    TrafficSpy::Application.create(identifier: "turing", root_url: "http://turing.io")

    payload_data_1 = {
      relative_path: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 80,
      referred_by:"http://turing.io",
      request_type:"GET",
      event: "socialLoginC",
      operating_system: "Macintosh",
      browser: "Chrome",
      resolution: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    payload_data_2 = {
      relative_path: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type:"GET",
      event: "socialLoginA",
      operating_system: "Macintosh",
      browser: "Safari",
      resolution: {width: "600", height: "800"},
      ip_address:"63.29.38.211"
    }

    payload_data_3 = {
      relative_path: "/blog",
      requested_at: "2013-02-16 19:38:28 -0700",
      responded_in: 50,
      referred_by:"http://turing.io",
      request_type:"POST",
      event: "socialLoginA",
      operating_system: "Windows",
      browser: "IE10",
      resolution: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    payload_data_4 = {
      relative_path: "/team",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 40,
      referred_by:"http://turing.io",
      request_type:"GET",
      event: "socialLoginB",
      operating_system: "Windows",
      browser: "Chrome",
      resolution: {width: "1920", height: "1080"},
      ip_address:"63.29.38.211"
    }

    payload_data_5 = {
      relative_path: "/team",
      requested_at: "2013-02-16 20:38:28 -0700",
      responded_in: 41,
      referred_by:"http://turing.io",
      request_type:"GET",
      event: "socialLoginB",
      operating_system: "Macintosh",
      browser: "Chrome",
      resolution: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    payload_data_6 = {
      relative_path: "/about",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 25,
      referred_by:"http://turing.io",
      request_type:"GET",
      event: "socialLoginB",
      operating_system: "Macintosh",
      browser: "Mozilla",
      resolution: {width: "1366", height: "768"},
      ip_address:"63.29.38.211"
    }

    payloads = [payload_data_1, payload_data_2, payload_data_3,
                payload_data_4, payload_data_5, payload_data_6]

    app = TrafficSpy::Application.find_by(identifier: "turing")

    payloads.each do |data|
      app.payloads.create(data)
    end
  end
end
