ENV["RACK_ENV"] ||= "test"
require 'tilt/erb'

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara'

Capybara.app = TrafficSpy::Server
# DatabaseCleaner[:sequel, { :connection => Sequel.sqlite("db/robot_world_test.sqlite3") }].strategy = :truncation

class Minitest::Test
  # def setup
  #   DatabaseCleaner.start
  # end
  #
  # def teardown
  #   DatabaseCleaner.clean
  # end
end

class FeatureTest < Minitest::Test
  include Capybara::DSL
end
