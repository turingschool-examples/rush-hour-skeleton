ENV["RACK_ENV"] = "test"

require File.expand_path("../../config/environment", __FILE__)
require "minitest/autorun"
require "minitest/pride"
require "capybara"

Capybara.app = TrafficSpy::Server

require "database_cleaner"

DatabaseCleaner.strategy = :truncation, { :except => %w[public.schema_migrations]}

class FeatureTest < Minitest::Test
  include Capybara::DSL

  def register_user_and_create_payload
    Source.create({ identifier: "jumpstartlab",
                    root_url: "http://jumpstartlab.com" })
    payload_params = '{"url":"http://jumpstartlab.com/contact","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'
    PayloadGenerator.call(payload_params, 'jumpstartlab')
  end

  def teardown
    DatabaseCleaner.clean
  end
end

