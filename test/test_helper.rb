ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation, {except: %w[public.schema_migrations]}

module TestHelpers
  def setup
    DatabaseCleaner.start
    super
  end

  def teardown
    DatabaseCleaner.clean
    super
  end

  def create_payload_request
    ({
      url: Url.find_or_create_by(address: 'http://jumpstartlab.com/blog'),
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referrer: Referrer.find_or_create_by(address: 'http://jumpstartlab.com'),
      request: Request.find_or_create_by(verb: "GET"),
      event: Event.find_or_create_by(name: 'socialLogin'),
      user_agent: UserAgent.find_or_create_by(browser: "Chrome", platform: "Macintosh"),
      resolution: Resolution.find_or_create_by(width: "1920", height: "1280"),
      ip: Ip.find_or_create_by(address: "63.29.38.211")
    })
  end
end

Capybara.app = RushHour::Server
