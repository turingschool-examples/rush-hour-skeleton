ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'
require 'database_cleaner'
# require 'erb/tilt'
require 'pry'

Capybara.app = RushHour::Server

module TestHelpers
  def setup
    DatabaseCleaner.start
    super
  end

  def teardown
    DatabaseCleaner.clean
    super
  end

  def app
    RushHour::Server
  end

  def setup_data
    [PayloadRequest.create(url: Url.first_or_create(address: "http://jumpstartlab.com"),
                               referrer: Referrer.first_or_create(address: "http://amazon.com"),
                               request_type: RequestType.first_or_create(verb: "GET"),
                               event: Event.first_or_create(name: "facebook"),
                               user_agent: UserAgent.first_or_create(browser: "Mozilla", platform: "Windows"),
                               resolution: Resolution.first_or_create(width: "2560", height: "1440"),
                               ip: Ip.first_or_create(address: "63.29.38.211"),
                               requested_at: "2013-02-16 21:40:00 -0700",
                               responded_in: 20
                              ),
    PayloadRequest.create(url: Url.first_or_create(address: "http://turing.io"),
                               referrer: Referrer.first_or_create(address: "http://amazon.com"),
                               request_type: RequestType.first_or_create(verb: "GET"),
                               event: Event.first_or_create(name: "facebook"),
                               user_agent: UserAgent.first_or_create(browser: "Chrome", platform: "Webkit"),
                               resolution: Resolution.first_or_create(width: "1920", height: "1280"),
                               ip: Ip.first_or_create(address: "63.29.38.211"),
                               requested_at: "2013-02-16 21:37:00 -0700",
                               responded_in: 30
                              ),
    PayloadRequest.create(url: Url.first_or_create(address: "http://jumpstartlab.com"),
                               referrer: Referrer.first_or_create(address: "http://newegg.com"),
                               request_type: RequestType.first_or_create(verb: "POST"),
                               event: Event.first_or_create(name: "twitter"),
                               user_agent: UserAgent.first_or_create(browser: "Safari", platform: "Macintosh"),
                               resolution: Resolution.first_or_create(width: "1920", height: "1280"), ip: Ip.first_or_create(address: "63.29.38.200"),
                               requested_at: "2013-16 21:38:00 -0700",
                               responded_in: 40
                              )]
  end

  def setup_client
    Client.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")
  end

  def register_client
    post '/sources', {client: {identifier: "jumpstartlab",
                                root_url: "http://jumpstartlab.com"
                   }}
  end

  def referrer_data #REDO
    [PayloadRequest.create(url: Url.first_or_create(address: "http://jumpstartlab.com"),
                               referrer: Referrer.first_or_create(address: "http://amazon.com"),
                               request_type: RequestType.first_or_create(verb: "GET"),
                               event: Event.first_or_create(name: "facebook"),
                               user_agent: UserAgent.first_or_create(browser: "Mozilla", platform: "Windows"),
                               resolution: Resolution.first_or_create(width: "2560", height: "1440"),
                               ip: Ip.first_or_create(address: "63.29.38.211"),
                               requested_at: "2013-02-16 21:40:00 -0700",
                               responded_in: 20
                              ),
    PayloadRequest.create(url: Url.first_or_create(address: "http://turing.io"),
                               referrer: Referrer.first_or_create(address: "http://amazon.com"),
                               request_type: RequestType.first_or_create(verb: "GET"),
                               event: Event.first_or_create(name: "facebook"),
                               user_agent: UserAgent.first_or_create(browser: "Chrome", platform: "Webkit"),
                               resolution: Resolution.first_or_create(width: "1920", height: "1280"),
                               ip: Ip.first_or_create(address: "63.29.38.211"),
                               requested_at: "2013-02-16 21:37:00 -0700",
                               responded_in: 30
                              ),
    PayloadRequest.create(url: Url.first_or_create(address: "http://jumpstartlab.com"),
                               referrer: Referrer.first_or_create(address: "http://newegg.com"),
                               request_type: RequestType.first_or_create(verb: "POST"),
                               event: Event.first_or_create(name: "twitter"),
                               user_agent: UserAgent.first_or_create(browser: "Safari", platform: "Macintosh"),
                               resolution: Resolution.first_or_create(width: "1920", height: "1280"),
                               ip: Ip.first_or_create(address: "63.29.38.200"),
                               requested_at: "2013-02-16 21:38:00 -0700",
                               responded_in: 40
                              ),
    PayloadRequest.create(url: Url.first_or_create(address: "http://turing.io"),
                               referrer: Referrer.first_or_create(address: "http://jumpstartlab.com"),
                               request_type: RequestType.first_or_create(verb: "GET"),
                               event: Event.first_or_create(name: "socialLogin"),
                               user_agent: UserAgent.first_or_create(browser: "Chrome", platform: "Macintosh"),
                               resolution: Resolution.first_or_create(width: "1920", height: "1280"),
                               ip: Ip.first_or_create(address: "63.29.38.224"),
                               requested_at: "2013-02-15 21:38:28 -0700",
                               responded_in: 10
                              ),
    PayloadRequest.create(url: Url.first_or_create(address: "http://turing.io"),
                               referrer: Referrer.first_or_create(address: "http://jumpstartlab.com"),
                               request_type: RequestType.first_or_create(verb: "GET"),
                               event: Event.first_or_create(name: "socialLogin"),
                               user_agent: UserAgent.first_or_create(browser: "Chrome", platform: "Macintosh"),
                               resolution: Resolution.first_or_create(width: "1920", height: "1280"),
                               ip: Ip.first_or_create(address: "63.29.38.224"), requested_at: "2013-02-15 21:38:28 -0700",
                               responded_in: 10
                              )]

  end
end

DatabaseCleaner.strategy = :truncation, {except: %w[public.schema_migrations]}

Capybara.app = RushHour::Server
