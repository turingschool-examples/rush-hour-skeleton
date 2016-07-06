ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'
require 'database_cleaner'

module TestHelpers

  DatabaseCleaner.strategy = :truncation

  DatabaseCleaner.start

  DatabaseCleaner.clean
end

Capybara.app = RushHour::Server
