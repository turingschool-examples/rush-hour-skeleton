ENV["RACK_ENV"] ||= "test"

require 'simplecov'
SimpleCov.start

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'
require 'database_cleaner'
require 'useragent'

DatabaseCleaner.strategy = :truncation
Capybara.app = RushHour::Server

module TestHelpers
  def software_agent(path = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17")

   UserAgent.parse(path)

  end

 def create_software_agent
   SoftwareAgent.create(
   browser: software_agent.browser,
   os: software_agent.platform
   )
 end

  def create_payload

    url           = Url.create(address: "http://jumpstartlab.com/blog")
    requested_at  = Time.now
    request_type  = RequestType.create(verb: "GET")
    resolution    = Resolution.create(width: "1920", height: "1280")
    referrer      = Referrer.create(address: "http://jumpstartlab.com")
    software_agent = SoftwareAgent.create(os: "OSX 10.11.5", browser: "Chrome")
    ip            = Ip.create(address: "63.29.38.211")

    payload_request     = PayloadRequest.create(url_id: url.id, requested_at: requested_at, responded_in: 5,
                                    referred_by_id: referrer.id, request_type_id: request_type.id,
                                    software_agent_id: software_agent.id, resolution_id: resolution.id,
                                    ip_id: ip.id)
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
