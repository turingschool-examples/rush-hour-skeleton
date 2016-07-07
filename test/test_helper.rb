ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'
require 'database_cleaner'
require 'json'

DatabaseCleaner.strategy = :truncation

module TestHelpers

  def create_url
    Url.create(
      address: payload_parser[:url],
      referred_by_id: create_referred_by
      )
  end

  def create_ip
    Ip.create(
    address: payload_parser[:ip]
    )
  end

  def create_referred_by
    ReferredBy.create(
      address: payload_parser[:referred_by]
    )
  end

  def create_resolution
    Resolution.create(
    width: payload_parser[:resolution_width],
    height: payload_parser[:resolution_height],
    )
  end

  def create_user_agent
    UserAgent.create(
    browser: payload_parser[:user_agent]
    )
  end

  def create_request_type
    RequestType.create(
    verb: payload_parser[:request_type]
    )
  end

  def create_payload(n)
    n.times do
      PayloadRequest.create(
      requested_at: payload_parser[:requested_at],
      responded_in: payload_parser[:responded_in],
      url_id: create_url,
      ip_id: create_ip,
      request_type_id: create_request_type,
      user_agent_id: create_user_agent,
      resolution_id: create_resolution
      )
    end
  end

  def payload
    JSON.parse(raw_payload)
  end

  def payload_parser
    {
    :url => payload["url"],
    :requested_at => payload["requestedAt"],
    :responded_in => payload["respondedIn"],
    :referred_by => payload["referredBy"],
    :request_type => payload["requestType"],
    :user_agent => payload["userAgent"],
    :resolution_width => payload["resolutionWidth"],
    :resolution_height => payload["resolutionHeight"],
    :ip => payload["ip"]
    }
  end

  def raw_payload
    '{
    "url":"http://jumpstartlab.com/blog",
    "requestedAt":"2013-02-16 21:38:28 -0700",
    "respondedIn":37,
    "referredBy":"http://jumpstartlab.com",
    "requestType":"GET",
    "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
    "resolutionWidth":"1920",
    "resolutionHeight":"1280",
    "ip":"63.29.38.211"
  }'
  end

  def setup
    DatabaseCleaner.start
    super
  end

  def teardown
    DatabaseCleaner.clean
    super
  end

end

Capybara.app = RushHour::Server
