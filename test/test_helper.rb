ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'

Capybara.app = RushHour::Server



module TestHelpers

  def payload_requests
    PayloadRequest.new
  end

  def teardown
    PayloadRequest.destroy_all
    super
  end
end
