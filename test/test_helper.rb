ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'
require 'database_cleaner'
require 'useragent'

Capybara.app = RushHour::Server
Capybara.save_and_open_page_path = "tmp/capybara"

DatabaseCleaner.strategy = :truncation, {except: %w[public.schema_migrations]}

module TestHelpers
    include Rack::Test::Methods

  def setup
    DatabaseCleaner.start
    super
  end

  def teardown
    DatabaseCleaner.clean
    super
  end

  def app     # def app is something that Rack::Test is looking for
    RushHour::Server
  end

#change find_or_create_by to this format:
#GroupMember.where(:member_id => 4, :group_id => 7).first_or_create

  def create_payload_1
    payload1 = {
      url_id:           Url.find_or_create_by(address: "http://jumpstartlab.com/blog").id,
      requested_at:     "2013-02-16 21:38:28 -0700",
      responded_in:     30,
      referrer_url_id:  ReferrerUrl.find_or_create_by(url_address: "http://jumpstartlab.com").id,
      request_type_id:  RequestType.find_or_create_by(verb: "GET").id,
      parameters:       [],
      event_name_id:    EventName.find_or_create_by(event_name: "socialLogin").id,
      user_system_id:   UserSystem.find_or_create_by(
                          browser_type: "Firefox",
                          operating_system: "Mac OSX",
                          unique_sha: Digest::SHA1.hexdigest("#{rand(9999999)}")).id,
      resolution_id:    Resolution.find_or_create_by(
                          width: "960",
                          height: "1400",
                          unique_sha: Digest::SHA1.hexdigest("#{rand(9999999)}")).id,
      ip_id:            Ip.find_or_create_by(ip_address: "63.29.38.211").id,
      client_id:        Client.find_or_create_by(
                          identifier: "google",
                          root_url:   "http://www.google.com").id,
      unique_sha:       Digest::SHA1.hexdigest("1")
    }
    PayloadRequest.create(payload1)
  end

  def create_payload_2
    payload2 = {
      url_id:           Url.find_or_create_by(address: "http://jumpstartlab.com/tutorials").id,
      requested_at:     "2014-02-16 21:38:28 -0700",
      responded_in:     40,
      referrer_url_id:  ReferrerUrl.find_or_create_by(url_address: "http://jumpstartlab.com").id,
      request_type_id:  RequestType.find_or_create_by(verb: "POST").id,
      parameters:       [],
      event_name_id:    EventName.find_or_create_by(event_name: "signOut").id,
      user_system_id:   UserSystem.find_or_create_by(
                          browser_type: "Safari",
                          operating_system: "Windows", unique_sha: Digest::SHA1.hexdigest("#{rand(9999999)}")).id,
      resolution_id:    Resolution.find_or_create_by(
                          width: "1920",
                          height: "1280",
                          unique_sha: Digest::SHA1.hexdigest("#{rand(9999999)}")).id,

      ip_id:            Ip.find_or_create_by(ip_address: "63.29.38.211").id,
      client_id:        Client.find_or_create_by(
                          identifier: "google",
                          root_url:   "http://www.google.com").id,
      unique_sha:       Digest::SHA1.hexdigest("#{rand(9999999)}")
    }
    PayloadRequest.create(payload2)
  end

  def create_payload_3
    payload3 = {
      url_id:           Url.find_or_create_by(address: "http://jumpstartlab.com").id,
      requested_at:     "2015-02-16 21:38:28 -0700",
      responded_in:     50,
      referrer_url_id:  ReferrerUrl.find_or_create_by(url_address: "http://jumpstartlab.com").id,
      request_type_id:  RequestType.find_or_create_by(verb: "PUT").id,
      parameters:       [],
      event_name_id:    EventName.find_or_create_by(event_name: "socialLogin").id,
      user_system_id:   UserSystem.find_or_create_by(
                          browser_type: "Firefox",
                          operating_system: "Mac OSX",
                          unique_sha: Digest::SHA1.hexdigest("#{rand(9999999)}")).id,
      resolution_id:    Resolution.find_or_create_by(
                          width: "1920",
                          height: "1280",
                          unique_sha: Digest::SHA1.hexdigest("#{rand(9999999)}")).id,
      ip_id:            Ip.find_or_create_by(ip_address: "63.29.38.211").id,
      client_id:        Client.find_or_create_by(
                          identifier: "google",
                          root_url:   "http://www.google.com").id,
      unique_sha:       Digest::SHA1.hexdigest("#{rand(9999999)}")
    }
    PayloadRequest.create(payload3)
  end

  def create_payload_4
    payload4 = {
      url_id:           Url.find_or_create_by(address: "http://jumpstartlab.com").id,
      requested_at:     "2013-02-16 21:38:28 -0700",
      responded_in:     30,
      referrer_url_id:  ReferrerUrl.find_or_create_by(url_address: "http://jumpstartlab.com").id,
      request_type_id:  RequestType.find_or_create_by(verb: "POST").id,
      parameters:       [],
      event_name_id:    EventName.find_or_create_by(event_name: "socialLogin").id,
      user_system_id:   UserSystem.find_or_create_by(
                          browser_type: "Chrome",
                          operating_system: "Mac OSX").id,
      resolution_id:    Resolution.find_or_create_by(
                          width: "1920",
                          height: "1280").id,
      ip_id:            Ip.find_or_create_by(ip_address: "63.29.38.211").id,
      client_id:        Client.find_or_create_by(
                          identifier: "google",
                          root_url:   "http://www.google.com").id,
      unique_sha:       Digest::SHA1.hexdigest("#{rand(9999999)}")
    }
    PayloadRequest.create(payload4)
  end

  def create_payload_5
    payload5 = {
      url_id:           Url.find_or_create_by(address: "http://jumpstartlab.com").id,
      requested_at:     "2014-02-16 21:38:28 -0700",
      responded_in:     40,
      referrer_url_id:  ReferrerUrl.find_or_create_by(url_address: "http://google.com").id,
      request_type_id:  RequestType.find_or_create_by(verb: "POST").id,
      parameters:       [],
      event_name_id:    EventName.find_or_create_by(event_name: "socialLogin").id,
      user_system_id:   UserSystem.find_or_create_by(
                          browser_type: "Firefox",
                          operating_system: "Windows").id,
      resolution_id:    Resolution.find_or_create_by(
                          width: "1920",
                          height: "1280").id,
      ip_id:            Ip.find_or_create_by(ip_address: "63.29.38.211").id,
      client_id:        Client.find_or_create_by(
                          identifier: "google",
                          root_url:   "http://www.google.com").id,
      unique_sha:       Digest::SHA1.hexdigest("#{rand(9999999)}")
    }
    PayloadRequest.create(payload5)
  end

  def create_payload_6
    payload6 = {
      url_id:           Url.find_or_create_by(address: "http://jumpstartlab.com/blog").id,
      requested_at:     "2015-02-16 21:38:28 -0700",
      responded_in:     50,
      referrer_url_id:  ReferrerUrl.find_or_create_by(url_address: "http://yahoo.com").id,
      request_type_id:  RequestType.find_or_create_by(verb: "PUT").id,
      parameters:       [],
      event_name_id:    EventName.find_or_create_by(event_name: "socialLogin").id,
      user_system_id:   UserSystem.find_or_create_by(
                          browser_type: "Safari",
                          operating_system: "iphone").id,
      resolution_id:    Resolution.find_or_create_by(
                          width: "1920",
                          height: "1280").id,
      ip_id:            Ip.find_or_create_by(ip_address: "63.29.38.211").id,
      client_id:        Client.find_or_create_by(
                          identifier: "google",
                          root_url:   "http://www.google.com").id,
      unique_sha:       Digest::SHA1.hexdigest("#{rand(9999999)}")
    }

    PayloadRequest.create(payload6)
  end

  def create_payload_7
    payload7 = {
      url_id:           Url.find_or_create_by(address: "http://jumpstartlab.com").id,
      requested_at:     "2015-02-16 21:38:28 -0700",
      responded_in:     50,
      referrer_url_id:  ReferrerUrl.find_or_create_by(url_address: "http://askjeeves.com").id,
      request_type_id:  RequestType.find_or_create_by(verb: "PUT").id,
      parameters:       [],
      event_name_id:    EventName.find_or_create_by(event_name: "socialLogin").id,
      user_system_id:   UserSystem.find_or_create_by(
                          browser_type: "Chrome",
                          operating_system: "Mac OSX").id,
      resolution_id:    Resolution.find_or_create_by(
                          width: "1920",
                          height: "1280").id,
      ip_id:            Ip.find_or_create_by(ip_address: "63.29.38.211").id,
      client_id:        Client.find_or_create_by(
                          identifier: "google",
                          root_url:   "http://www.google.com").id,
      unique_sha:       Digest::SHA1.hexdigest("#{rand(9999999)}")
    }
    PayloadRequest.create(payload7)
  end

  def create_payload_8
    payload8 = {
      url_id:           Url.find_or_create_by(address: "http://jumpstartlab.com").id,
      requested_at:     "2015-02-16 21:38:28 -0700",
      responded_in:     50,
      referrer_url_id:  ReferrerUrl.find_or_create_by(url_address: "http://yahoo.com").id,
      request_type_id:  RequestType.find_or_create_by(verb: "PUT").id,
      parameters:       [],
      event_name_id:    EventName.find_or_create_by(event_name: "socialLogin").id,
      user_system_id:   UserSystem.find_or_create_by(
                          browser_type: "Safari",
                          operating_system: "Windows").id,
      resolution_id:    Resolution.find_or_create_by(
                          width: "1920",
                          height: "1280").id,
      ip_id:            Ip.find_or_create_by(ip_address: "63.29.38.211").id,
      client_id:        Client.find_or_create_by(
                          identifier: "google",
                          root_url:   "http://www.google.com").id,
      unique_sha:       Digest::SHA1.hexdigest("#{rand(9999999)}")
    }
    PayloadRequest.create(payload8)
  end
end

class FeatureTest < Minitest::Test
  include Capybara::DSL
  include TestHelpers
end
