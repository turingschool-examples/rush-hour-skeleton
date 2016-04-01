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
    [PayloadRequest.create(url: Url.find_or_create_by(address: "http://jumpstartlab.com"),
                               referrer: Referrer.find_or_create_by(address: "http://amazon.com"),
                               request_type: RequestType.find_or_create_by(verb: "GET"),
                               event: Event.find_or_create_by(name: "facebook"),
                               u_agent: UAgent.find_or_create_by(browser: "Mozilla", platform: "Windows"),
                               resolution: Resolution.find_or_create_by(width: "2560", height: "1440"),
                               ip: Ip.find_or_create_by(address: "63.29.38.211"),
                               requested_at: "2013-02-16 21:40:00 -0700",
                               responded_in: 20
                              ),
    PayloadRequest.create(url: Url.find_or_create_by(address: "http://turing.io"),
                               referrer: Referrer.find_or_create_by(address: "http://amazon.com"),
                               request_type: RequestType.find_or_create_by(verb: "GET"),
                               event: Event.find_or_create_by(name: "facebook"),
                               u_agent: UAgent.find_or_create_by(browser: "Chrome", platform: "Webkit"),
                               resolution: Resolution.find_or_create_by(width: "1920", height: "1280"),
                               ip: Ip.find_or_create_by(address: "63.29.38.211"),
                               requested_at: "2013-02-16 21:37:00 -0700",
                               responded_in: 30
                              ),
    PayloadRequest.create(url: Url.find_or_create_by(address: "http://jumpstartlab.com"),
                               referrer: Referrer.find_or_create_by(address: "http://newegg.com"),
                               request_type: RequestType.find_or_create_by(verb: "POST"),
                               event: Event.find_or_create_by(name: "twitter"),
                               u_agent: UAgent.find_or_create_by(browser: "Safari", platform: "Macintosh"),
                               resolution: Resolution.find_or_create_by(width: "1920", height: "1280"),
                               ip: Ip.first_or_create(address: "63.29.38.200"),
                               requested_at: "2013-16 21:38:00 -0700",
                               responded_in: 40
                              )]
  end

  def setup_client
    Client.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")
  end

  def register_client
    post '/sources', {identifier: "jumpstartlab",
                                rootUrl: "http://jumpstartlab.com"
                   }
  end

  def referrer_data #REDO
    [PayloadRequest.create(url: Url.find_or_create_by(address: "http://turing.io"),
                               referrer: Referrer.find_or_create_by(address: "http://amazon.com"),
                               request_type: RequestType.find_or_create_by(verb: "GET"),
                               event: Event.find_or_create_by(name: "facebook"),
                               u_agent: UAgent.find_or_create_by(browser: "Mozilla", platform: "Windows"),
                               resolution: Resolution.find_or_create_by(width: "2560", height: "1440"),
                               ip: Ip.find_or_create_by(address: "63.29.38.211"),
                               requested_at: "2013-02-16 21:40:00 -0700",
                               responded_in: 20
                              ),
    PayloadRequest.create(url: Url.find_or_create_by(address: "http://turing.io"),
                               referrer: Referrer.find_or_create_by(address: "http://amazon.com"),
                               request_type: RequestType.find_or_create_by(verb: "GET"),
                               event: Event.find_or_create_by(name: "facebook"),
                               u_agent: UAgent.find_or_create_by(browser: "Chrome", platform: "Webkit"),
                               resolution: Resolution.find_or_create_by(width: "1920", height: "1280"),
                               ip: Ip.find_or_create_by(address: "63.29.38.211"),
                               requested_at: "2013-02-16 21:37:00 -0700",
                               responded_in: 30
                              ),
    PayloadRequest.create(url: Url.find_or_create_by(address:  "http://turing.io"),
                               referrer: Referrer.find_or_create_by(address: "http://newegg.com"),
                               request_type: RequestType.find_or_create_by(verb: "POST"),
                               event: Event.find_or_create_by(name: "twitter"),
                               u_agent: UAgent.find_or_create_by(browser: "Safari", platform: "Macintosh"),
                               resolution: Resolution.find_or_create_by(width: "1920", height: "1280"),
                               ip: Ip.find_or_create_by(address: "63.29.38.200"),
                               requested_at: "2013-02-16 21:38:00 -0700",
                               responded_in: 40
                              ),
    PayloadRequest.create(url: Url.find_or_create_by(address: "http://turing.io"),
                               referrer: Referrer.find_or_create_by(address: "http://jumpstartlab.com"),
                               request_type: RequestType.find_or_create_by(verb: "GET"),
                               event: Event.find_or_create_by(name: "socialLogin"),
                               u_agent: UAgent.find_or_create_by(browser: "Chrome", platform: "Macintosh"),
                               resolution: Resolution.find_or_create_by(width: "1920", height: "1280"),
                               ip: Ip.find_or_create_by(address: "63.29.38.224"),
                               requested_at: "2013-02-15 21:38:28 -0700",
                               responded_in: 10
                              ),
    PayloadRequest.create(url: Url.find_or_create_by(address: "http://turing.io"),
                               referrer: Referrer.find_or_create_by(address: "http://jumpstartlab.com"),
                               request_type: RequestType.find_or_create_by(verb: "GET"),
                               event: Event.find_or_create_by(name: "socialLogin"),
                               u_agent: UAgent.find_or_create_by(browser: "Chrome", platform: "Macintosh"),
                               resolution: Resolution.find_or_create_by(width: "1920", height: "1280"),
                               ip: Ip.find_or_create_by(address: "63.29.38.224"), requested_at: "2013-02-15 21:38:28 -0700",
                               responded_in: 10
                              )]
  end

  def get_params
    {
			'url' => "http://jumpstartlab.com/blog",
			'requested_at' => "2013-02-16 21:38:28 -0700",
			'responded_in' => 37,
			'referrer' => "http://jumpstartlab.com",
			'request_type' => "GET",
			'parameters' => [],
			'event' => "socialLogin",
			'u_agent' => "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
			'resolution_width' => "1920",
			'resolution_height' => "1280",
			'ip' => "63.29.38.211"
		}
  end
end

DatabaseCleaner.strategy = :truncation, {except: %w[public.schema_migrations]}

Capybara.app = RushHour::Server
