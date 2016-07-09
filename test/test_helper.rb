ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require_relative '../app/models/url'
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'
require 'database_cleaner'
require 'json'
require 'useragent'
require 'faker'
require 'rack/test'

DatabaseCleaner.strategy = :truncation

module TestHelpers
  include Rack::Test::Methods

  def app
    RushHour::Server
  end


  def create_url
    Url.create(
      address: payload_parser[:url]
      )
  end

  def create_ip
    Ip.create(
    address: payload_parser[:ip]
    )
  end

  def create_referral
    Referral.create(
      address: payload_parser[:referral]
    )
  end

  def create_resolution
    Resolution.create(
    width: payload_parser[:resolution_width],
    height: payload_parser[:resolution_height],
    )
  end

  def create_software_agent
    SoftwareAgent.create(
    message: payload_parser[:software_agent]
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
      url_id: create_url.id,
      ip_id: create_ip.id,
      request_type_id: create_request_type.id,
      software_agent_id: create_software_agent.id,
      resolution_id: create_resolution.id,
      client_id: Client.create(identifier: rand(1..1000), root_url: rand(1..1000)).id,
      referral_id: create_faker_referral.id
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
    :referral => payload["referredBy"],
    :request_type => payload["requestType"],
    :software_agent => payload["userAgent"],
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

  def create_faker_payloads(n)
    n.times do
      time = Faker::Time.between(2.days.ago, Date.today, :all).to_s
      PayloadRequest.create(
      requested_at: time,
      responded_in: rand(20..50),
      url_id: create_faker_url.id,
      ip_id: create_faker_ip.id,
      request_type_id: create_faker_request_type.id,
      software_agent_id: create_faker_software_agent.id,
      resolution_id: create_faker_resolution.id,
      client_id: Client.create(identifier: rand(1..1000), root_url: rand(1..1000)).id,
      referral_id: create_faker_referral.id
      )
    end
  end

  def create_faker_url
    urls = ['http://example.com/jasonisnice', 'http://example.com/mattisnice', 'http://example.com/weloveangela', 'http://example.com/robertaisnice']
    Url.find_or_create_by(
    address: urls.sample
    )
  end

  def create_faker_ip
    Ip.find_or_create_by(
    address: Faker::Internet.ip_v4_address
    )
  end

  def create_faker_referral
    addresses = []
    address1 = 'http://www.example.com'
    address2 = 'http://www.nba.com'
    address3 = 'http://www.facebook.com'
    address4 = 'http://www.nfl.com'
    address5 = 'http://www.google.com'
    address6 = 'http://www.mlb.com'
    address7 = 'http://www.oddmanout.com'

    addresses.push(address1, address2, address3, address4, address5, address6, address7)

    Referral.find_or_create_by(
      address: addresses.sample
    )
  end

  def create_faker_resolution
    resolutions = [["1280", "800"], ["1020", "640"], ["1520", "1080"]]
    width_height = resolutions.sample
    Resolution.find_or_create_by(
    width: width_height[0],
    height: width_height[1]
    )
  end

  def create_faker_software_agent #use different os
    messages = []
    message1 = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17"
    message2 = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Safari/24.0.1309.0 Safari/537.17"
    message3 = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Firefox/24.0.1309.0 Safari/537.17"
    messages.push(message1, message2, message3)
    SoftwareAgent.find_or_create_by(
    message: messages.sample
    )
  end

  def create_faker_request_type
    verbs = ["GET", "PUT", "POST", "DELETE"]
    RequestType.find_or_create_by(
    verb: verbs.sample
    )
  end

  def three_relationship_requests
    PayloadRequest.create(
    requested_at: Faker::Time.between(2.days.ago, Date.today, :all).to_s,
    responded_in: 37,
    url_id: Url.find_or_create_by(address: "http://example.com/jasonisnice").id,
    ip_id: create_faker_ip.id,
    request_type_id: RequestType.find_or_create_by(verb: "GET").id,
    software_agent_id: create_faker_software_agent.id,
    resolution_id: create_faker_resolution.id,
    client_id: Client.find_or_create_by(identifier: 'jumpstartlab', root_url: "http://jumpstartlab.com").id,
    referral_id: create_faker_referral.id
    )
    PayloadRequest.create(
    requested_at: Faker::Time.between(2.days.ago, Date.today, :all).to_s,
    responded_in: 28,
    url_id:  Url.find_or_create_by(address: "http://example.com/jasonisnice").id,
    ip_id: create_faker_ip.id,
    request_type_id: RequestType.find_or_create_by(verb: "POST").id,
    software_agent_id: create_faker_software_agent.id,
    resolution_id: create_faker_resolution.id,
    client_id: Client.find_or_create_by(identifier: 'startlab', root_url: "http://jumpstartlab.com").id,
    referral_id: create_faker_referral.id
    )
    PayloadRequest.create(
    requested_at: Faker::Time.between(2.days.ago, Date.today, :all).to_s,
    responded_in: 42,
    url_id: Url.find_or_create_by(address: "http://example.com/mattisnice").id,
    ip_id: create_faker_ip.id,
    request_type_id: RequestType.find_or_create_by(verb: "POST").id,
    software_agent_id: create_faker_software_agent.id,
    resolution_id: create_faker_resolution.id,
    client_id: Client.find_or_create_by(identifier: 'jumplab', root_url: "http://jumpstartlab.com").id,
    referral_id: create_faker_referral.id
    )
  end

  def three_software_agents
    SoftwareAgent.create(message: "Mozilla/5.0 (Macintosh; iOS) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17")
    SoftwareAgent.create(message: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Safari/24.0.1309.0 Safari/537.17")
    SoftwareAgent.create(message: "Mozilla/5.0 (Macintosh; Windows XP) AppleWebKit/537.17 (KHTML, like Gecko) Firefox/24.0.1309.0 Safari/537.17")
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
