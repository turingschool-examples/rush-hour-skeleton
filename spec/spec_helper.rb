ENV["RACK_ENV"] ||= "test"

require File.expand_path("../../config/environment", __FILE__)
require 'rspec'
require 'capybara/dsl'

DatabaseCleaner.strategy = :truncation

Capybara.app = RushHour::Server

RSpec.configure do |c|
  c.include Capybara::DSL
end
