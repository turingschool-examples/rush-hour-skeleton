ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'
require 'database_cleaner'
require 'pry'
require 'tilt/erb'

module TestHelpers
  def setup
    DatabaseCleaner.start
    super
  end

  def teardown
    DatabaseCleaner.clean
    super
  end

  def app
    RushHour::Server
  end

  def setup_1
    data1 = {
      requested_at: "2013-02-16 22:38:28 -0700",
      response_time: 20,
      event_id: Event.where(name: "socialLogin").first_or_create.id,
      ip_id: Ip.where(address: "63.29.38.211").first_or_create.id,
      refer_id: Refer.where(address: "http://google.com").first_or_create.id,
      resolution_id: Resolution.where(width: "1000", height: "1000").first_or_create.id,
      url_id: Url.where(address: "http://jumpstartlab.com").first_or_create.id,
      user_environment_id: UserEnvironment.where(browser: "Mozilla", os: "windows").first_or_create.id,
      request_type_id: RequestType.where(verb: "POST").first_or_create.id
    }

    data2 = {
      requested_at: "2013-02-16 21:38:28 -0700",
      response_time: 30,
      event_id: Event.where(name: "differentEvent").first_or_create.id,
      ip_id: Ip.where(address: "63.29.38.211").first_or_create.id,
      refer_id: Refer.where(address: "http://turing.io").first_or_create.id,
      resolution_id: Resolution.where(width: "2000", height: "2000").first_or_create.id,
      url_id: Url.where(address: "http://jumpstartlab.com").first_or_create.id,
      user_environment_id: UserEnvironment.where(browser: "Safari", os: "doors").first_or_create.id,
      request_type_id: RequestType.where(verb: "GET").first_or_create.id
    }
    data3 = {
      requested_at: "2013-02-16 22:38:29 -0700",
      response_time: 40,
      event_id: Event.where(name: "socialLogin").first_or_create.id,
      ip_id: Ip.where(address: "62.29.38.211").first_or_create.id,
      refer_id: Refer.where(address: "http://www.google.com").first_or_create.id,
      resolution_id: Resolution.where(width: "500", height: "500").first_or_create.id,
      url_id: Url.where(address: "http://jumpstartlab.com/jumps").first_or_create.id,
      user_environment_id: UserEnvironment.where(browser: "Chrome", os: "SOS").first_or_create.id,
      request_type_id: RequestType.where(verb: "GET").first_or_create.id
    }

    payload_1 = Payload.create(data1)
    payload_2 = Payload.create(data2)
    payload_3 = Payload.create(data3)
  end

  def setup_referrers
    refer1 = {
      requested_at: "2013-02-18 22:38:28 -0700",
      response_time: 50,
      event_id: Event.where(name: "socialLogin").first_or_create.id,
      ip_id: Ip.where(address: "67.29.38.211").first_or_create.id,
      refer_id: Refer.where(address: "http://turing.io").first_or_create.id,
      resolution_id: Resolution.where(width: "500", height: "500").first_or_create.id,
      url_id: Url.where(address: "http://jumpstartlab.com").first_or_create.id,
      user_environment_id: UserEnvironment.where(browser: "Chrome", os: "SOS").first_or_create.id,
      request_type_id: RequestType.where(verb: "GET").first_or_create.id
    }

    refer2 = {
      requested_at: "2012-02-16 22:38:28 -0700",
      response_time: 20,
      event_id: Event.where(name: "socialLogin").first_or_create.id,
      ip_id: Ip.where(address: "65.29.38.211").first_or_create.id,
      refer_id: Refer.where(address: "http://turing.io").first_or_create.id,
      resolution_id: Resolution.where(width: "500", height: "500").first_or_create.id,
      url_id: Url.where(address: "http://jumpstartlab.com").first_or_create.id,
      user_environment_id: UserEnvironment.where(browser: "Chrome", os: "SOS").first_or_create.id,
      request_type_id: RequestType.where(verb: "GET").first_or_create.id
    }
    Payload.create(refer1)
    Payload.create(refer2)
  end

  def client_setup
    post '/sources', {"identifier"=>"jumpstartlab",
          "rootUrl"=>"http://jumpstartlab.com"}
  end

  def payload_setup1
    raw1 = {"payload" => {
      "url":"http://jumpstartlab.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":37,
      "referredBy":"http://jumpstartlab.com",
      "requestType":"GET",
      "parameters":["this"],
      "eventName":"socialLogin",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"63.29.38.211"}.to_json}

    post '/sources/jumpstartlab/data', raw1
  end

  def payload_setup2
    raw2 = { "payload" =>
      {"url":"http://turing.io/test",
      "requestedAt":"2014-02-16 22:38:28 -0800",
      "respondedIn":25,
      "referredBy":"http://turing.io",
      "requestType":"POST",
      "parameters":["that"],
      "eventName":"socialLogin",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1480",
      "resolutionHeight":"1200",
      "ip":"73.29.38.211"}.to_json
      }

    post '/sources/turing/data', raw2
  end

  def payload_setup_not_registered
    raw3 = { "payload" =>
      {"url":"http://example.com/test",
      "requestedAt":"2014-02-16 22:38:28 -0800",
      "respondedIn":25,
      "referredBy":"http://turing.io",
      "requestType":"POST",
      "parameters":["that"],
      "eventName":"socialLogin",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1480",
      "resolutionHeight":"1200",
      "ip":"73.29.38.211"}.to_json
      }

    post '/sources/jumpstartlab/data', raw3
  end
end


DatabaseCleaner.strategy = :truncation, {except: %w[public.schema_migrations]}

Capybara.app = RushHour::Server
Capybara.save_and_open_page_path = 'tmp/capybara'

class FeatureTest < Minitest::Test
  include Capybara::DSL
  include Rack::Test::Methods
end
