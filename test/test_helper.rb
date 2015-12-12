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

  def register_turing_and_send_multiple_payloads
    TrafficSpy::Application.create(identifier: "turing", root_url: "http://turing.io")

    payload_data_1 = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 80,
      referred_by:"http://turing.io",
      request_type_string:"GET",
      event_string: "socialLoginC",
      operating_system_string: "Macintosh",
      browser_string: "Chrome",
      resolution_string: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    payload_data_2 = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type_string:"GET",
      event_string: "socialLoginA",
      operating_system_string: "Macintosh",
      browser_string: "Safari",
      resolution_string: {width: "600", height: "800"},
      ip_address:"63.29.38.211"
    }

    payload_data_3 = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 19:38:28 -0700",
      responded_in: 50,
      referred_by:"http://facebook.com",
      request_type_string:"POST",
      event_string: "socialLoginA",
      operating_system_string: "Windows",
      browser_string: "IE10",
      resolution_string: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    payload_data_4 = {
      relative_path_string: "/team",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 40,
      referred_by:"http://turing.io",
      request_type_string:"GET",
      event_string: "socialLoginB",
      operating_system_string: "Windows",
      browser_string: "Chrome",
      resolution_string: {width: "1920", height: "1080"},
      ip_address:"63.29.38.211"
    }

    payload_data_5 = {
      relative_path_string: "/team",
      requested_at: "2013-02-16 20:38:28 -0700",
      responded_in: 41,
      referred_by:"http://turing.io",
      request_type_string:"GET",
      event_string: "socialLoginB",
      operating_system_string: "Macintosh",
      browser_string: "Chrome",
      resolution_string: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    payload_data_6 = {
      relative_path_string: "/about",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 25,
      referred_by:"http://turing.io",
      request_type_string:"GET",
      event_string: "socialLoginB",
      operating_system_string: "Macintosh",
      browser_string: "Mozilla",
      resolution_string: {width: "1366", height: "768"},
      ip_address:"63.29.38.211"
    }

    payloads = [payload_data_1, payload_data_2, payload_data_3,
                payload_data_4, payload_data_5, payload_data_6]

    app = TrafficSpy::Application.find_by(identifier: "turing")

    payloads.each do |payload_data|
      data = TrafficSpy::DataLoader.new(payload_data).find_ids
      data[:application_id] = app.id

      TrafficSpy::Payload.create(data)
    end
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

end
