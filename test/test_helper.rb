ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'
require 'database_cleaner'
require 'pry'

module TestHelpers
  def setup
    DatabaseCleaner.start
    super
  end

  def teardown
    DatabaseCleaner.clean
    super
  end

  def setup_1
    @data1 = {
      requested_at: "2013-02-16 22:38:28 -0700",
      response_time: 20,
      parameters: ["query"],
      event_id: Event.create(name: "socialLogin").id,
      ip_id: Ip.create(address: "63.29.38.211").id,
      refer_id: Refer.create(address: "http://google.com").id,
      resolution_id: Resolution.create(width: "1000", height: "1000").id,
      url_id: Url.create(address: "http://jumpstartlab.com").id,
      user_environment_id: UserEnvironment.create(browser: "Mozilla", os: "windows").id,
      request_type_id: RequestType.create(verb: "POST").id
    }

    @data2 = {
      requested_at: "2013-02-16 21:38:28 -0700",
      response_time: 30,
      parameters: ["query"],
      event_id: Event.create(name: "differentEvent").id,
      ip_id: Ip.create(address: "63.29.38.211").id,
      refer_id: Refer.create(address: "http://turing.io").id,
      resolution_id: Resolution.create(width: "2000", height: "2000").id,
      url_id: Url.create(address: "http://jumpstartlab.com").id,
      user_environment_id: UserEnvironment.create(browser: "Safari", os: "doors").id,
      request_type_id: RequestType.create(verb: "GET").id
    }
    @data3 = {
      requested_at: "2013-02-16 22:38:28 -0700",
      response_time: 40,
      parameters: ["query"],
      event_id: Event.create(name: "socialLogin").id,
      ip_id: Ip.create(address: "62.29.38.211").id,
      refer_id: Refer.create(address: "http://jumpstartlab.com").id,
      resolution_id: Resolution.create(width: "500", height: "500").id,
      url_id: Url.create(address: "http://jumpstartlab.com/jumps").id,
      user_environment_id: UserEnvironment.create(browser: "Chrome", os: "SOS").id,
      request_type_id: RequestType.create(verb: "GET").id
    }
    @payload_1 = Payload.create(@data1)
    @payload_2 = Payload.create(@data2)
    @payload_3 = Payload.create(@data3)
  end

end


DatabaseCleaner.strategy = :truncation, {except: %w[public.schema_migrations]}
Capybara.app = RushHour::Server
