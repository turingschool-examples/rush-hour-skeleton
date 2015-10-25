ENV["RACK_ENV"] = "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara'
require 'database_cleaner'
require 'tilt/erb'

Capybara.app = TrafficSpy::Server
DatabaseCleaner.strategy = :truncation, {except: %w[public.schema_migrations]}

class Minitest::Test
  include Rack::Test::Methods

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

  def app
    TrafficSpy::Server
  end

  def create_sources(num)
    num.times do |i|
      TrafficSpy::Source.create({identifier: "#{i+1}",
                                 root_url: "#{i+1}"
                                })
    end
  end

  def create_payloads(num)
    num.times do |i|
      payloads = TrafficSpy::Payload.create({:url=>"#{i+1}",
                      :requested_at=>"#{i+1}",
                      :respondedIn=>"#{i+1}",
                      :referredBy=>"#{i+1}",
                      :requestType=>"#{i+1}",
                      :parameters=>"#{i+1}",
                      :eventName=>"#{i+1}",
                      :userAgent=>"#{i+1}",
                      :resolutionWidth=>"#{i+1}",
                      :resolutionHeight=>"#{i+1}",
                      :ip=>"#{i+1}"})
    end
    payloads
  end
end

class FeatureTest < Minitest::Test
  include Capybara::DSL

  def authorize_admin
    if page.driver.respond_to?(:basic_auth)
      page.driver.basic_auth('admin', 'admin')
    elsif page.driver.respond_to?(:basic_authorize)
      page.driver.basic_authorize('admin', 'admin')
    elsif page.driver.respond_to?(:browser) && page.driver.browser.respond_to?(:basic_authorize)
      page.driver.browser.basic_authorize('admin', 'admin')
    else
      raise "Can't login"
    end
  end
end

class TrafficSpy::Server < Sinatra::Base
  set :environment, :test
end
