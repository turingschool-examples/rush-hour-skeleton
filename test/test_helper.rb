ENV["RACK_ENV"] = "test"

require File.expand_path("../../config/environment", __FILE__)
require "minitest/autorun"
require "minitest/pride"
require "capybara"

Capybara.app = TrafficSpy::Server

require "database_cleaner"
DatabaseCleaner.strategy = :truncation, { :except => %w[public.schema_migrations]}

class FeatureTest < Minitest::Test
  include Capybara::DSL

end