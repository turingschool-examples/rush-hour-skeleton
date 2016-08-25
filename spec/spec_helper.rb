ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
# require 'minitest/autorun'
# require 'minitest/pride'
require 'capybara/dsl'
require 'rspec'
require 'database_cleaner'
require 'pry'
# require 'active_record'

Capybara.app = RushHour::Server

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean_with(:truncation)
# module TestHelpers
# #   before :each do
# #     DatabaseCleaner.start
# #   end
# #
#   after :each do
#     DatabaseCleaner.clean
#   end
# end
