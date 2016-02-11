ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'
require 'database_cleaner'

Capybara.app = RushHour::Server

DatabaseCleaner.strategy = :truncation, {except: %w[public.schema_migrations]}

module TestHelpers
  def setup
    DatabaseCleaner.start
    super
  end

  def payload
    {
      "url":"http://jumpstartlab.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":37,
      "referredBy":"http://jumpstartlab.com",
      "requestType":"GET",
      "parameters":[],
      "eventName": "socialLogin",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"63.29.38.211"
    }
  end

  def teardown
    DatabaseCleaner.clean
    super
  end

  def create_payload_request(responded_in = payload[:respondedIn])
    PayloadRequest.create(requested_at: payload[:requestedAt],
                                   responded_in: responded_in,
                                   event_name: payload[:eventName])
  end

  def create_verb(method)
    Verb.create(request_type: method)
  end

  def create_payload_with_associations
    url_1 = create_url_request("http://jumpstartlab.com/blog")
    url_2 = create_url_request("http://google.com")
    verb_1 = create_verb("GET")
    verb_2 = create_verb("POST")
    user_agent_1 = create_user_agent("Mozilla", "Windows")
    user_agent_2 = create_user_agent("Chrome", "Android")

    payload_1 = create_payload_request
    payload_2 = create_payload_request
    payload_3 = create_payload_request

    payload_1.update(url_request_id: url_1.id, verb_id: verb_1.id, user_agent_id: user_agent_1.id)
    payload_2.update(url_request_id: url_1.id, verb_id: verb_2.id, user_agent_id: user_agent_2.id)
    payload_3.update(url_request_id: url_2.id, verb_id: verb_1.id, user_agent_id: user_agent_1.id)
  end

  def create_url_request(url)
    UrlRequest.create(url: url, parameters: payload[:parameters])
  end

  def create_user_agent(browser, os)
    UserAgent.create(browser: browser, os: os)
  end
end
