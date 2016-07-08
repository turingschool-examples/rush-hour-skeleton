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

Capybara.app = RushHour::Server


module TestHelpers

  def app
    RushHour
  end

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

  def payload
    '{"url":"http://jumpstartlab.com/blog",
    "requestedAt":"2013-02-16 21:38:28 -0700",
    "respondedIn":37,
    "referredBy":"http://jumpstartlab.com",
    "requestType":"GET",
    "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
    "resolutionWidth":"1920",
    "resolutionHeight":"1280",
    "ip":"63.29.38.211"}'
  end

  def parsed_payload
    JSON.parse(payload)
  end

  def create_payload
   url             = Url.find_or_create_by(root: find_root(parsed_payload["url"], path: find_path(parsed_payload["url"]))"/blog")
   request_type    = RequestType.find_or_create_by(verb: parsed_payload["requestType"])
   resolution      = Resolution.find_or_create_by(height: parsed_payload["resolutionHeight"], width: parsed_payload["resolutionWidth"])
   referral        = Referral.find_or_create_by(name: parsed_payload["referredBy"])
   user_agent_device = UserAgentDevice.find_or_create_by(os: "OSX 10.11.5", browser: "Chrome")
   ip              = Ip.find_or_create_by(ip_address: parsed_payload["ip"])
   payload_request = PayloadRequest.find_or_create_by(url_id: 1, requested_at: "#{Time.now}",
                     responded_in: 5, referral_id: referral.id,
                     request_type_id: request_type.id, user_agent_device_id: user_agent_device.id,
                     resolution_id: resolution.id, ip_id: ip.id)
    p payload_request
 end

end
