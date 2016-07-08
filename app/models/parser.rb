class Parser

  def self.parsed_real_payload
    JSON.parse(real_payloads)
  end

  def self.parsed_payload(num)
    JSON.parse(raw_payloads(num))
  end
  #
  # def self.parsed_root
  #   URI.parse(parsed_payload["url"]).host
  # end
  #
  # def self.parsed_path
  #   URI.parse(parsed_payload["url"]).path
  # end
  #
  # def self.parsed_os
  #   UserAgent.parse(parsed_payload["userAgent"]).platform
  # end
  #
  # def self.parsed_browser
  #   UserAgent.parse(parsed_payload["userAgent"]).browser
  # end

end

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

  def raw_payloads(num=1)
    '{"url":"http://jumpstartlab.com/blog",
    "requestedAt":"2013-02-16 21:38:28 -0700",
    "respondedIn":37,
    "referredBy":"http://jumpstartlab.com",
    "requestType":"GET",
    "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
    "resolutionWidth":"1890",
    "resolutionHeight":"1210",
    "ip":"63.29.38.211"}'
  end

  def parsed_payload(num=1)
    JSON.parse(raw_payloads(num=1))
  end

  def create_payload(num=1)
    num.times do |i|
      PayloadRequest.create({
      url: Url.find_or_create_by(root: URI.parse(parsed_payload["url"]).host, path: URI.parse(parsed_payload["url"]).path),
      requested_at: Time.now.to_s,
      responded_in: 5,
      referral: Referral.find_or_create_by(name: parsed_payload["referredBy"]),
      request_type: RequestType.find_or_create_by(verb: parsed_payload["requestType"]),
      user_agent_device: UserAgentDevice.find_or_create_by(os: UserAgent.parse(parsed_payload["userAgent"]).platform, browser: UserAgent.parse(parsed_payload["userAgent"]).browser),
      resolution: Resolution.find_or_create_by(height: parsed_payload["resolutionHeight"]),
      ip: Ip.find_or_create_by(ip_address: parsed_payload["ip"])
      })
    end
  end

 #  def create_payload(num=1)
 #    num.times do |i|
 #   url             = Url.find_or_create_by(root: URI.parse(parsed_payload["url"]).host, path: URI.parse(parsed_payload["url"]).path)
 #   request_type    = RequestType.find_or_create_by(verb: parsed_payload["requestType"])
 #   resolution      = Resolution.find_or_create_by(height: parsed_payload["resolutionHeight"], width: parsed_payload["resolutionWidth"])
 #   referral        = Referral.find_or_create_by(name: parsed_payload["referredBy"])
 #   user_agent_device = UserAgentDevice.find_or_create_by(os: UserAgent.parse(parsed_payload["userAgent"]).platform, browser: UserAgent.parse(parsed_payload["userAgent"]).browser)
 #   ip              = Ip.find_or_create_by(ip_address: parsed_payload["ip"])
 #
 #   payload_request = PayloadRequest.find_or_create_by(url_id: 1, requested_at: Time.now.to_s,
 #                     responded_in: 5, referral_id: referral.id,
 #                     request_type_id: request_type.id, user_agent_device_id: user_agent_device.id,
 #                     resolution_id: resolution.id, ip_id: ip.id)
 #    end
 #  p payload_request
 #
 # end

  #
  # def create_payload(num)
  #   num.times do |i|
  #     payload_request = PayloadRequest.create(
  #     url: create_url,
  #     requested_at: Time.now.to_s,
  #     responded_in: 5,
  #     referral: create_referral,
  #     request_type: create_request_type,
  #     user_agent_device: create_user_agent_device,
  #     resolution: create_resolution,
  #     ip: create_ip)
  #   end
  # end

  # def create_url
  #   root = URI.parse(parsed_payload["url"]).host
  #   path = URI.parse(parsed_payload["url"]).path
  #   Url.find_or_create_by(root: root, path: path)
  # end
  #
  # def create_request_type
  #   RequestType.find_or_create_by(verb: parsed_payload["requestType"])
  # end
  #
  # def create_resolution
  #   Resolution.find_or_create_by(height: parsed_payload["resolutionHeight"],
  #   width: parsed_payload["resolutionWidth"])
  # end
  #
  # def create_referral
  #   Referral.find_or_create_by(name: parsed_payload["referredBy"])
  # end
  #
  # def create_user_agent_device
  #   os =      UserAgent.parse(parsed_payload["userAgent"]).platform
  #   browser = UserAgent.parse(parsed_payload["userAgent"]).browser
  #   UserAgentDevice.find_or_create_by(os: os, browser: browser)
  # end
  #
  # def create_ip
  #   Ip.find_or_create_by(ip_address: parsed_payload["ip"])
  # end

end
