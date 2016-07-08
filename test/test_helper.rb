ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'
require 'database_cleaner'
require 'json'
require 'uri'
require 'useragent'

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
   url             = Url.find_or_create_by(root: parsed_root, path: parsed_path)
   request_type    = RequestType.find_or_create_by(verb: parsed_payload["requestType"])
   resolution      = Resolution.find_or_create_by(height: parsed_payload["resolutionHeight"], width: parsed_payload["resolutionWidth"])
   referral        = Referral.find_or_create_by(name: parsed_payload["referredBy"])
   user_agent_device = UserAgentDevice.find_or_create_by(os: parsed_os, browser: parsed_browser)
   ip              = Ip.find_or_create_by(ip_address: parsed_payload["ip"])

   payload_request = PayloadRequest.create({url_id: 1, requested_at: Time.now.to_s,
                     responded_in: 5, referral_id: referral.id,
                     request_type_id: request_type.id, user_agent_device_id: user_agent_device.id,
                     resolution_id: resolution.id, ip_id: ip.id})
  p payload_request
 end

 def parsed_root
   URI.parse(parsed_payload["url"]).host
 end

 def parsed_path
   URI.parse(parsed_payload["url"]).path
 end

 def parsed_os
   UserAgent.parse(parsed_payload["userAgent"]).platform
 end

 def parsed_browser
   UserAgent.parse(parsed_payload["userAgent"]).browser
 end

end
# def create_payload(number = 1)
#
#   number.times do |i|
#
#   url               = Url.find_or_create_by({root: "http://jumpstartlab.com", path: "/path"})
#   referral          = Referral.find_or_create_by({name: "http://jumpstartlab.com"})
#   request_type      = RequestType.find_or_create_by({verb: "GET"})
#   user_agent_device = UserAgentDevice.find_or_create_by({os: "Mozilla/5.0", browser: "Macintosh; Intel Mac OS X 10_8_2"})
#   resolution        = Resolution.find_or_create_by({height: "1920", width: "1280"})
#   ip                = Ip.find_or_create_by({ip_address: "63.29.38.211"})
#
#   payload_request = PayloadRequest.create({
#     url_id: url,
#     requested_at: Time.now.to_s,
#     responded_in: 10,
#     referral_id: referral,
#     request_type_id: request_type,
#     user_agent_device_id: user_agent_device,
#     resolution_id: resolution,
#     ip_id: ip})
#   end
# end
