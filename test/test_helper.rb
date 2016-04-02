ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'
require 'database_cleaner'
require 'tilt/erb'

Capybara.app = RushHour::Server

DatabaseCleaner.strategy = :truncation, {except: %w[public.schema_migrations]}

module TestHelper

  def setup
    DatabaseCleaner.start
    super
  end

  def teardown
    DatabaseCleaner.clean
    super
  end

  def create_client
    Client.create(
      identifier: "jumpstartlabs",
      root_url:    "www.jumpstartlabs.com")
  end

  def create_generic_payload_requests
    PayloadRequest.create(
      url_id:          1,
      requested_at:    "2013-02-16 21:38:28 -0700",
      response_time:   100,
      referral_id:     1,
      request_type_id: 1,
      event_id:        1,
      user_agent_id:   1,
      resolution_id:   1,
      ip_id:           1,
      client_id:       1)
    PayloadRequest.create(
      url_id:          1,
      requested_at:    "2013-02-16 21:38:28 -0700",
      response_time:   300,
      referral_id:     1,
      request_type_id: 1,
      event_id:        1,
      user_agent_id:   1,
      resolution_id:   1,
      ip_id:           1,
      client_id:       1 )
  end

  def create_user_agent
    UserAgent.create(browser: "IE 9.0",
                     os:      "Mac OS X 10.8.2")
  end

  def create_request_type
    RequestType.create(verb: "GET")
  end

  def create_url
    Url.create(root_url: "www.example.com",
               path:     "/")
  end

  def create_resolution
    Resolution.create(width: "1200",
                      height: "1920")
  end

  def create_referral
    Referral.create(root_url: "http://www.example.com",
                    path:     "/")
  end
end
