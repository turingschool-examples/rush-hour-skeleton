ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/emoji'
require 'capybara/dsl'
require 'database_cleaner'
require 'rack/test'

Capybara.app = RushHour::Server

DatabaseCleaner.strategy = :truncation, {except: %w([public.schema.migrations])}

module TestHelpers
  include Rack::Test::Methods

  def app
    Server
  end

  def setup
    DatabaseCleaner.start
    super
  end

  def teardown
    DatabaseCleaner.clean
    super
  end

  def create_payloads(num)
    payloads = []
    num.times do |i|
      payloads << '{
        "url":"'"http://jumpstartlab.com/#{i}"'",
        "requestedAt":"'"#{Time.now}"'",
        "respondedIn":'"#{i * 10}"',
        "referredBy":"'"http://jumpstartlab.com/#{i}"'",
        "requestType":"'"#{["GET", "PUT", "POST"].sample}"'",
        "parameters": [],
        "eventName":"'"socialLogin#{i}"'",
        "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
        "resolutionWidth":"1920",
        "resolutionHeight":"1280",
        "ip":"'"63.29.38.21#{i}"'"
      }'

    end
    payloads
  end

  def create_payloads_with_same_references_for_url(num, reference)
    payloads = []
    num.times do |i|
      payloads << '{
        "url":"http://jumpstartlab.com/",
        "requestedAt":"'"#{Time.now}"'",
        "respondedIn":'"#{i * 10}"',
        "referredBy":"'"#{reference}"'",
        "requestType":"'"#{["GET", "PUT", "POST"].sample}"'",
        "parameters": [],
        "eventName":"'"socialLogin#{i}"'",
        "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
        "resolutionWidth":"1920",
        "resolutionHeight":"1280",
        "ip":"'"63.29.38.21#{i}"'"
      }'

    end
    payloads
  end


  def create_payloads_with_same_user_agent_for_url(num, os, browser)
    payloads = []
    num.times do |i|
      payloads << '{
        "url":"http://jumpstartlab.com/",
        "requestedAt":"'"#{Time.now}"'",
        "respondedIn":'"#{i * 10}"',
        "referredBy":"'"http://google.com"'",
        "requestType":"'"#{["GET", "PUT", "POST"].sample}"'",
        "parameters": [],
        "eventName":"'"socialLogin#{i}"'",
        "userAgent":"'"Mozilla/5.0 (Macintosh; Intel #{os}) AppleWebKit/537.17 (KHTML, like Gecko) #{browser}/24.0.1309.0 Safari/537.17"'",
        "resolutionWidth":"1920",
        "resolutionHeight":"1280",
        "ip":"'"63.29.38.21#{i}"'"
      }'

    end
    payloads
  end
end
#database cleaner will do the same as a teardown
#might want to make a module for testhelpers later for capybara etc.
#create a parser in models- camel case info
#gem for user_agent
#any time you make a structural change, run 'rake db:test:prepare'
#responds_to? method for testing (does it have a method you can call on it)
#basic structure for html and css
#if we do 2 right, we should have calculations in place for later iterations.
#get it to work then refactor
