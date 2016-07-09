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

  # def create_single_payload(number=1)
  #   number.times do |i|
  #     dp = DataParser.new(payload)
  #     dp.parse_payload
  #     end
  #   end

  def parsed_payload
    JSON.parse(payload)
  end

  def create_multiple_payloads(number=2)
    number.times do |i|
      url               = Url.find_or_create_by(root: parsed_root, path: parsed_path.insert(-1, "#{i}"))
      request_type      = RequestType.find_or_create_by(verb: parsed_payload["requestType"])
      resolution        = Resolution.find_or_create_by(height: parsed_payload["resolutionHeight"], width: parsed_payload["resolutionWidth"].insert(-1, "#{i}"))
      referral          = Referral.find_or_create_by(name: parsed_payload["referredBy"].insert(-1, "#{i}"))
      user_agent_device = UserAgentDevice.find_or_create_by(os: parsed_os, browser: parsed_browser.insert(-1, "#{i}"))
      ip                = Ip.find_or_create_by(ip_address: parsed_payload["ip"].insert(-1, "#{i}"))
      payload_request   = PayloadRequest.create({url_id: url.id, requested_at: Time.now.to_s,
        responded_in: 5 *(i + 1), referral_id: referral.id,
        request_type_id: request_type.id, user_agent_device_id: user_agent_device.id,
        resolution_id: resolution.id, ip_id: ip.id, sha: Digest::SHA256.digest("#{i + 1}")})
      p payload_request
    end
  end
  # Digest::SHA256.digest(parsed_payload(payload)

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
