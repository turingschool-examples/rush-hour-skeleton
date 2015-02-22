ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara'
require 'database_cleaner'
require 'pry'

DatabaseCleaner.strategy = :truncation, {:except => %w[public.schema_migrations]}

class FeatureTest < Minitest::Test
  include Capybara::DSL
  require_relative './fixtures/sample_payloads'

  # def generate_payload(payload)
  #   #we can extract a method that will generate a 
  #   #payload. We will want to reuse it multiple times so 
  #   #it makes sense to have it here instead of in every 
  #   #separate feature test
  # end

end

Capybara.app = TrafficSpy::Server
