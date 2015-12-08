ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation, { except: %w[public.schema_migrations] }

Capybara.app = TrafficSpy::Server

class Minitest::Test

  # def setup
  #   DatabaseCleaner.start
  # end
  #
  # def teardown
  #   DatabaseCleaner.clean
  # end

end
