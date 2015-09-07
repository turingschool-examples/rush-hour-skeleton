ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara'
require 'database_cleaner'
require 'pry'
require 'json'
require 'tilt/erb'
require 'user_agent'

DatabaseCleaner.strategy = :truncation, {except: %w[public.schema_migration]}

Capybara.app = TrafficSpy::Server
