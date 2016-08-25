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
# DatabaseCleaner.clean_with(:truncation)
# module TestHelpers
#   after :each do
#     DatabaseCleaner.clean
#     super
#   end
# end

# RSpec.configure do |config|
#
#   config.before(:suite) do
#     DatabaseCleaner.strategy = :transaction
#     DatabaseCleaner.clean_with(:truncation)
#   end
#
#   config.around(:each) do |example|
#     DatabaseCleaner.cleaning do
#       example.run
#     end
#   end
#
# end



# def data
#     hash = {"url_id"                =>  "http://www.google.com",
#     "requested_at"          =>  "2013-02-16 21:38:28 -0700"}
#
#     clean_data = {"url_id" => Url.find_or_create_by(address: hash["url_id"]).id}
#     PayloadRequest.create(clean_data)
# end
#
# curl -i -d "payload='{'url': 'http://www.google.com'}'" localhost:9393/data
#
# post '/data' do
#   data = JSON.parse(params["payload"])
#   change_attributes(data)
# end
