ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'capybara'
require 'database_cleaner'
require 'pry'
require 'tilt/erb'

DatabaseCleaner.strategy = :truncation, {except: %w[public.schema_migrations]}

Capybara.app = TrafficSpy::Server

class Minitest::Test
  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

end

class FeatureTest < Minitest::Test
  include Capybara::DSL

  def create_user(num)
    num.times do |i|
      User.create("identifier" => "test_company_#{i+1}", "rootUrl" => "HTTP://Example#{i+1}.com")
    end
  end

  def create_payloads_three
      Payload.create({url: "http://test_company_1.com/blog",
                      requestedAt: "2013-02-16 21:38:28 -0700",
                      respondedIn: 37,
                      referredBy: "http://test_company_1.com",
                      requestType: "GET",
                      eventName:  "socialLogin",
                      userAgent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                      resolutionWidth: "1920",
                      resolutionHeight: "1280",
                      sha: "12abed344gfvdaddg",
                      user_id: "test_company_1",
                      ip: "63.29.38.211"})

      Payload.create({url: "http://test_company_1.com/page",
                      requestedAt: "2013-02-16 21:38:28 -0700",
                      respondedIn: 27,
                      referredBy: "http://test_company_1.com",
                      requestType: "GET",
                      eventName:  "socialLogin",
                      userAgent: "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:40.0) Gecko/20100101 Firefox/40.1",
                      resolutionWidth: "2048",
                      resolutionHeight: "1536",
                      sha: "12aewokeo454fe",
                      user_id: "test_company_1",
                      ip: "63.29.38.211"})

      Payload.create({url: "http://test_company_1.com/page",
                      requestedAt: "2013-02-16 21:38:28 -0700",
                      respondedIn: 45,
                      referredBy: "http://test_company_1.com",
                      requestType: "GET",
                      eventName:  "socialLogin",
                      userAgent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                      resolutionWidth: "1920",
                      resolutionHeight: "1280",
                      sha: "12abedfog8erevdaddg",
                      user_id: "test_company_1",
                      ip: "63.29.38.211"})

    end

end
