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
      TrafficSpy::Payload.create({:url=>"http://#{i+1}/blog",
                      :requested_at=>"2013-02-16 21:38:28 -0700",
                      :responded_in=>37,
                      :referred_by=>"http://jumpstartlab.com",
                      :request_type=>"GET",
                      :parameters=>[],
                      :event_name=>"socialLogin",
                      :user_agent=>"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                      :resolution_width=>"1920",
                      :resolution_height=>"1280",
                      :ip=>"63.29.38.211",
                      :unique_hash=>"#{i+1}"
                      })
    end
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
