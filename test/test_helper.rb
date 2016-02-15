ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'
require 'database_cleaner'

Capybara.app = RushHour::Server
Capybara.save_and_open_page_path = 'tmp/capybara'

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

  def payload(data = {})
    {
      "url": data[:url] || "http://jumpstartlab.com/blog",
      "requestedAt": data[:requested_at] || "2013-02-16 21:38:28 -0700",
      "respondedIn": data[:responded_in] || 37,
      "referredBy": data[:referred_by] || "http://jumpstartlab.com",
      "requestType": data[:request_type] || "GET",
      "parameters": data[:parameters] ||"[]",
      "eventName": data[:event_name] || "socialLogin",
      "userAgent": data[:user_agent] || "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth": data[:resolution_width] || "1920",
      "resolutionHeight": data[:resolution_height] || "1280",
      "ip": data[:ip] || "63.29.38.211"
    }
  end

  def rand_time
    # this is a joke... kind of.
    Time.now + rand(1000000000000000000000900000000000000000000000000000000000000000000000)
  end

  def create_ip_address(data)
    IpAddress.find_or_create_by(ip: data[:ip])
  end

  def create_referrer(data)
    Referrer.find_or_create_by(referred_by: data[:referredBy])
  end

  def create_resolution(data)
    Resolution.find_or_create_by(resolution_width: data[:resolutionWidth],
                                 resolution_height: data[:resolutionHeight])
  end

  def create_url_request(data)
    UrlRequest.find_or_create_by(url: data[:url],
                                 parameters: data[:parameters])
  end

  def create_user_agent(parsed_user_agent)
    UserAgent.find_or_create_by(browser: parsed_user_agent.family.to_s,
                                os: parsed_user_agent.os.to_s)
  end

  def create_verb(data)
    Verb.find_or_create_by(request_type: data[:requestType])
  end

  def create_payload_request(data)
    PayloadRequest.create(requested_at: data[:requestedAt],
                          responded_in: data[:respondedIn],
                          event_name: data[:eventName])
  end

  def create_payload_requests_with_associations(data = {})
    new_payload = payload(data)
    ip          = create_ip_address(new_payload)
    referrer    = create_referrer(new_payload)
    resolution  = create_resolution(new_payload)
    url_request = create_url_request(new_payload)
    parsed_user_agent = UserAgentParser.parse(new_payload[:userAgent])
    user_agent  = create_user_agent(parsed_user_agent)
    verb        = create_verb(new_payload)
    payload_request = create_payload_request(new_payload)

    payload_request.update(ip_address_id: ip.id, referrer_id: referrer.id,
                           resolution_id: resolution.id, url_request_id: url_request.id,
                           user_agent_id: user_agent.id, verb_id: verb.id)
  end
end

class FeatureTest < Minitest::Test
  include Capybara::DSL
  include TestHelpers
end
