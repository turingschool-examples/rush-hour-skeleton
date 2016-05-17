ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'

Capybara.app = RushHour::Server

#database cleaner will do the same as a teardown
#might want to make a module for testhelpers later for capybara etc.
#create a parser in models- camel case info
#gem for user_agent
#any time you make a structural change, run 'rake db:test:prepare'
#responds_to? method for testing (does it have a method you can call on it)
#basic structure for html and css
#if we do 2 right, we should have calculations in place for later iterations.
#get it to work then refactor
