ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'
require 'database_cleaner'
require 'json'
require 'rack/test'

DatabaseCleaner.strategy = :truncation, {except: %w([public.schema.migrations])}

Capybara.app = RushHour::Server

module TestHelpers
  include Rack::Test::Methods

  def app
    RushHour::Server
  end

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

  def create_single_payload
    dp = DataParser.new(payload)
    dp.parse_payload
  end

  def create_client
    client = Client.new(identifier: "turing", root_url: "https://www.turing.io/")
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

  def create_multiple_payloads(number=2)
    number.times do |i|
      url               = Url.find_or_create_by(root: parsed_root, path: parsed_path.insert(-1, "#{i}"))
      request_type      = RequestType.find_or_create_by(verb: parsed_payload["requestType"])
      resolution        = Resolution.find_or_create_by(height: parsed_payload["resolutionHeight"], width: parsed_payload["resolutionWidth"].insert(-1, "#{i}"))
      referral          = Referral.find_or_create_by(name: parsed_payload["referredBy"].insert(-1, "#{i}"))
      user_agent_device = UserAgentDevice.find_or_create_by(os: parsed_os, browser: parsed_browser.insert(-1, "#{i}"))
      ip                = Ip.find_or_create_by(ip_address: parsed_payload["ip"].sub("6", "#{i}"))
      payload_request   = PayloadRequest.create({url: url,
        requested_at: "2013-02-16 2#{i}:38:28 -0700",
        responded_in: 5 *(i + 1),
        referral: referral,
        request_type: request_type,
        user_agent_device: user_agent_device,
        resolution: resolution,
        ip: ip,
        sha: Digest::SHA256.digest("#{i + 2}"),
        client: Client.find_or_create_by(identifier: "turing", root_url: "https://turing.io")
        })
      end
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

    def create_client
      Client.create(identifier: "turing", root_url: "https://turing.io")
    end

    def setup_for_url
      PayloadRequest.find_or_create_by({url: Url.find_or_create_by(root: "http://jumpstartlab.com", path: "/blog"),
        requested_at: "2014-02-16 21:38:28 -0700",
        responded_in: 0,
        referral: Referral.find_or_create_by(name: "http://jumpstartlab.com"),
        request_type: RequestType.find_or_create_by(verb: "GET"),
        user_agent_device: UserAgentDevice.find_or_create_by(os: "Chrome", browser: "Macintosh"),
        resolution: Resolution.find_or_create_by(height: "1280", width: "1920"),
        ip: Ip.find_or_create_by(ip_address: "33.33.33.333"),
        sha: Digest::SHA256.digest("data_one"),
        client: Client.find_or_create_by(identifier: "turing", root_url: "https://turing.io")
        })
        PayloadRequest.find_or_create_by({url: Url.find_or_create_by(root: "http://jumpstartlab.com", path: "/blog"),
          requested_at: "2015-02-16 21:38:28 -0700",
          responded_in: 50,
          referral: Referral.find_or_create_by(name: "http://layofflab.com"),
          request_type: RequestType.find_or_create_by(verb: "PUT"),
          user_agent_device: UserAgentDevice.find_or_create_by(os: "Safari", browser: "Mac"),
          resolution: Resolution.find_or_create_by(height: "1000", width: "2000"),
          ip: Ip.find_or_create_by(ip_address: "22.22.22.222"),
          sha: Digest::SHA256.digest("data_two"),
          client: Client.find_or_create_by(identifier: "turing", root_url: "https://turing.io")
          })
          PayloadRequest.find_or_create_by({url: Url.find_or_create_by(root: "http://jumpstartlab.com", path: "/blog"),
            requested_at: "2016-02-16 29:38:28 -0700",
            responded_in: 50,
            referral: Referral.find_or_create_by(name: "https://google.com"),
            request_type: RequestType.find_or_create_by(verb: "DELETE"),
            user_agent_device: UserAgentDevice.find_or_create_by(os: "SafariXL", browser: "Mac"),
            resolution: Resolution.find_or_create_by(height: "1000", width: "3000"),
            ip: Ip.find_or_create_by(ip_address: "22.22.22.222"),
            sha: Digest::SHA256.digest("data_two"),
            client: Client.find_or_create_by(identifier: "turing", root_url: "https://turing.io")
            })
          3.times do |i|
            PayloadRequest.find_or_create_by({url: Url.find_or_create_by(root: "http://jumpstartlab.com", path: "/blog"),
              requested_at: "2016-02-16 2#{i}:38:20 -0700",
              responded_in: 100,
              referral: Referral.find_or_create_by(name: "http://turing.io"),
              request_type: RequestType.find_or_create_by(verb: "POST"),
              user_agent_device: UserAgentDevice.find_or_create_by(os: "Firefox", browser: "Mac_daddy"),
              resolution: Resolution.find_or_create_by(height: "#{i}00", width: "900"),
              ip: Ip.find_or_create_by(ip_address: "6#{i}.66.66.666"),
              sha: Digest::SHA256.digest("data_three"),
              client: Client.find_or_create_by(identifier: "turing", root_url: "https://turing.io")
              })
          end
    end
end
