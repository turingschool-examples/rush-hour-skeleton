ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara'
require 'json'

Capybara.app = TrafficSpy::Server

class ControllerTest < Minitest::Test
  include Rack::Test::Methods

  def app
    TrafficSpy::Server
  end
end
