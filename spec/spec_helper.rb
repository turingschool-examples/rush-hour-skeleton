ENV["RACK_ENV"] ||= "test"

require File.expand_path("../../config/environment", __FILE__)
require 'rspec'
require 'capybara/dsl'

DatabaseCleaner.strategy = :truncation

Capybara.app = RushHour::Server

RSpec.configure do |c|
  c.include Capybara::DSL
end

RSpec.configure do |c|
  c.before(:all) do
    DatabaseCleaner.clean
  end
  c.after(:each) do
    DatabaseCleaner.clean
  end
end

def test_data
  '{
    "url":"http://jumpstartlab.com/blog",
    "requestedAt":"2013-02-16 21:38:28 -0700",
    "respondedIn":37,
    "referredBy":"http://jumpstartlab.com",
    "requestType":"GET",
    "eventName": "socialLogin",
    "userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
    "resolutionWidth":"1920",
    "resolutionHeight":"1280",
    "ip":"63.29.38.211"
  }'
end

def test_data_2
  {
    url:"http://jumpstartlab.com/blog",
    requestedAt:"2013-02-16 21:38:28 -0700",
    respondedIn:37,
    referredBy:"http://jumpstartlab.com",
    requestType:"GET",
    eventName: "socialLogin",
    userAgent:"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
    resolutionWidth:"1920",
    resolutionHeight:"1280",
    ip:"63.29.38.211"
  }
end

def json_test_data
  '{"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'
end

def create_single_client_and_payload
  Payload.create(url: Url.create(root_url: "google.com", path: "/images"),
                 responded_in: 12,
                 requested_at: "2013-01-16 23:38:28 -0700",
                 referred_by: ReferredBy.create(root_url: "google.com", path: "/images"),
                 request_type: RequestType.create(http_verb: "GET"),
                 event: Event.create(event_name: "socialLogin"),
                 agent: Agent.create(browser: "Safari", operating_system: "OSX"),
                 resolution: Resolution.create(width: 1200, height: 1800),
                 ip: Ip.create(address: '192.00.00.00'),
                 client: Client.create(identifier: "google", root_url: "/images"))
end

def create_multiple_payloads_for_single_client
  Client.create(identifier: "google", root_url: "/images")
  Url.create(root_url: "google.com", path: "/images")

  Payload.create(url: Url.find_by(root_url: "google.com", path: "/images"),
                 responded_in: 10,
                 requested_at: "2013-01-16 23:38:28 -0700",
                 referred_by: ReferredBy.create(root_url: "google.com", path: "/images"),
                 request_type: RequestType.create(http_verb: "GET"),
                 event: Event.create(event_name: "socialLogin"),
                 agent: Agent.create(browser: "Safari", operating_system: "OSX"),
                 resolution: Resolution.create(width: 1200, height: 1800),
                 ip: Ip.create(address: '192.00.00.00'),
                 client: Client.find_by(identifier: "google", root_url: "/images"))

   Payload.create(url: Url.find_by(root_url: "google.com", path: "/images"),
                  responded_in: 20,
                  requested_at: "2013-01-16 23:38:28 -0700",
                  referred_by: ReferredBy.create(root_url: "google.com", path: "/images"),
                  request_type: RequestType.create(http_verb: "GET"),
                  event: Event.create(event_name: "socialLogin"),
                  agent: Agent.create(browser: "Safari", operating_system: "OSX"),
                  resolution: Resolution.create(width: 1200, height: 1800),
                  ip: Ip.create(address: '192.00.00.00'),
                  client: Client.find_by(identifier: "google", root_url: "/images"))

  Payload.create(url: Url.find_by(root_url: "google.com", path: "/images"),
                 responded_in: 30,
                 requested_at: "2013-01-16 23:38:28 -0700",
                 referred_by: ReferredBy.create(root_url: "google.com", path: "/images"),
                 request_type: RequestType.create(http_verb: "GET"),
                 event: Event.create(event_name: "socialLogin"),
                 agent: Agent.create(browser: "Safari", operating_system: "OSX"),
                 resolution: Resolution.create(width: 1200, height: 1800),
                 ip: Ip.create(address: '192.00.00.00'),
                 client: Client.find_by(identifier: "google", root_url: "/images"))
end

def create_clients
  Client.create(identifier: "google", root_url: "/images")
  Client.create(identifier: "yahoo", root_url: "/images")
  Client.create(identifier: "facebook", root_url: "/images")
  Client.create(identifier: "apple", root_url: "/images")
  Client.create(identifier: "microsoft", root_url: "/images")
  Client.create(identifier: "jumpstartlab", root_url: "/images")
end
