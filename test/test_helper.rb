ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'
require 'database_cleaner'
require 'rack/test'

Capybara.app = RushHour::Server


DatabaseCleaner.strategy = :truncation
# , {except: %w([public.schema.migrations])}

module TestHelpers
  include Rack::Test::Methods
  def app
    RushHour::Server
  end

  def setup
    DatabaseCleaner.start
    super
  end

  def teardown
    DatabaseCleaner.clean
    super
  end
end

class FeatureTest < Minitest::Test
  include Capybara::DSL
  include TestHelpers
end
