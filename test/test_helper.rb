ENV["RACK_ENV"] ||= "test"

require 'simplecov'
SimpleCov.start

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'
require 'database_cleaner'
require 'useragent'

DatabaseCleaner.strategy = :truncation
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
end
