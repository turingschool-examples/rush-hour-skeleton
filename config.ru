ENV["RACK_ENV"]  ||= 'development'

require 'bundler'
Bundler.require

require File.expand_path('../config/environment',  __FILE__)

run TrafficSpy::Server
