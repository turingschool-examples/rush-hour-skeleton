ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'

Capybara.app = RushHour::Server

module TestHelpers

  def payload_requests
    PayloadRequest.new
  end

  def teardown
    PayloadRequest.destroy_all
    super
  end

  def create_payload
    url           = Url.create(address: "http://jumpstartlab.com/blog")
    request_type  = RequestType.create(verb: "GET")
    resolution    = Resolution.create(width: "1920", height: "1280")
    referrer      = Referrer.create(referrer: "http://jumpstartlab.com")
    user_agent    = UserAgent.create(operating_system: "OSX 10.11.5", browser: "Chrome")
    ip            = Ip.create(ip_address: "63.29.38.211")
    payload_request     = PayloadRequest.create(url_id: url.id, requested_at: "abcd", responded_in: "5",
                                    referrer_id: referrer.id, request_type_id: rtype.id,
                                    user_agent_id: user_agent.id, resolution_id: resolution.id,
                                    ip_address_id: ip.id)
  end
end
