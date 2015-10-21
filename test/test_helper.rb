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

#added by shannon on 10/19 - not sure if we need it with active record?
class Minitest::Test
  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end
end

class FeatureTest < MiniTest::Test
  include Capybara::DSL

  def create_user(num)
    # will create some users here - the INVENTORY variables
    # I'll give it the name test_company_1 where i is num
  end

  def create_event(num)
    # will create some users here - the INVENTORY variables
    # I'll give it the name event_1 where i is num
  end

  def create_url(num)
  end
end
