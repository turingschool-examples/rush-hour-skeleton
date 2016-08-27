ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'
require 'database_cleaner'

Capybara.app = RushHour::Server
DatabaseCleaner.strategy = :truncation

module TestHelpers
  def teardown
    DatabaseCleaner.clean
    super
  end
end

class ModelTest < Minitest::Test
  include TestHelpers
end

class ControllerTest < Minitest::Test
  include TestHelpers
  include Rack::Test::Methods

  def app
    RushHour::Server
  end
end
