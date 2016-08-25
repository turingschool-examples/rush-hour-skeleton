ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'
require 'database_cleaner'
require 'pg'
require './app/models/data_parser'

Capybara.app = RushHour::Server

DatabaseCleaner.strategy = :truncation

module TestHelpers
  def setup
    @payload = {
      "url":"http://jumpstartlab.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":37,
      "referredBy":"http://jumpstartlab.com",
      "requestType":"GET",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"63.29.38.211"
    }

    @payload2 = {
      "url":"http://google.com",
      "requestedAt":"2013-03-21 21:38:28 -0700",
      "respondedIn":41,
      "referredBy":"http://yahoo.com",
      "requestType":"POST",
      "userAgent":"Mozilla/7.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/537.17 (KHTML, like Gecko) Firefox/24.0.1309.0 Chrome/537.17",
      "resolutionWidth":"800",
      "resolutionHeight":"600",
      "ip":"34.32.40.211"
    }
    @payload3 = {
      "url":"http://jumpstartlab.com/",
      "requestedAt":"2015-02-16 21:38:28 -0700",
      "respondedIn":40,
      "referredBy":"http://google.com",
      "requestType":"GET",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"63.29.38.211"
    }

    DatabaseCleaner.clean
    super
  end

  def teardown
    DatabaseCleaner.clean
    super
  end

  def make_payloads
    payload1 = {
      "url":"http://mysite.com/",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":32,
      "referredBy":"http://www.google.com",
      "requestType":"GET",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"5.6.7.8"
    }
    payload2 = {
      "url":"http://mysite.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":37,
      "referredBy":"http://www.yahoo.com",
      "requestType":"GET",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"5.5.4.3"
    }
    payload3 = {
      "url":"http://mysite.com/",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":60,
      "referredBy":"http://www.google.com",
      "requestType":"POST",
      "userAgent":"Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.2309.372 Safari/537.36",
      "resolutionWidth":"640",
      "resolutionHeight":"480",
      "ip":"1.2.3.4"
    }
    DataParser.create(payload1)
    DataParser.create(payload2)
    DataParser.create(payload3)
  end
end
