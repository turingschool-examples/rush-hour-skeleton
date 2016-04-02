ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'
require 'database_cleaner'
require 'tilt/erb'

Capybara.app = RushHour::Server

DatabaseCleaner.strategy = :truncation, {except: %w[public.schema_migrations]}

module TestHelper

  def setup
    DatabaseCleaner.start
    super
  end

  def teardown
    DatabaseCleaner.clean
    super
  end

  def create_client
    Client.create(
      identifier: "jumpstartlabs",
      root_url:    "www.jumpstartlabs.com")
  end

end
