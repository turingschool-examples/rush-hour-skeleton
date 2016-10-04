ENV["RACK_ENV"] ||= "test"

require 'simplecov'
SimpleCov.start

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'
require 'database_cleaner'
require 'useragent'

DatabaseCleaner.strategy = :truncation

module TestHelpers
  include Rack::Test::Methods

  def setup
   DatabaseCleaner.start
   super
  end

  def teardown
   DatabaseCleaner.clean
    super
  end

  def app
    RushHour::Server
  end

  def software_agent(path = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17")
   UserAgent.parse(path)
  end

 def create_software_agent
   SoftwareAgent.create(
   browser: software_agent.browser,
   os: software_agent.platform
   )
 end

  def create_payload(integer)
    integer.times do |i|
    url            =  Url.find_or_create_by(address: "http://jumpstartlab.com/blog#{i}")
    requested_at   =  Time.now
    request_type   =  RequestType.create(verb: "GET #{i}")
    resolution     =  Resolution.create(width: "1920#{i}", height: "1280#{i}")
    referrer       =  Referrer.create(address: "http://jumpstartlab.com#{i}")
    software_agent =  SoftwareAgent.create(os: "OSX 10.11.5#{i}", browser: "Chrome#{i}")
    ip             =  Ip.create(address: "63.29.38.211#{i}")
    client         =  Client.find_or_create_by({:identifier => "jumpstartlab#{i}", :root_url => "http://jumpstartlab.com"})
    parameter      =  Parameter.find_or_create_by({user_input: "#{i}"})

    payload = PayloadRequest.find_or_create_by({
        :url_id => url.id,
        :requested_at => requested_at,
        :responded_in => i,
        :request_type_id => request_type.id,
        :resolution_id => resolution.id,
        :referred_by_id => referrer.id,
        :software_agent_id => software_agent.id,
        :ip_id => ip.id,
        :parameter_id => parameter.id,
        :client_id => client.id })
    end
  end

  def create_payload2(integer)
    integer.times do |i|
      url           = Url.find_or_create_by(address: "http://turing.io/blog")
      requested_at  = Time.now
      request_type  = RequestType.find_or_create_by(verb: "GET")
      resolution    = Resolution.find_or_create_by(width: "1366", height: "768")
      referrer      = Referrer.find_or_create_by(address: "http://turing.com")
      software_agent = SoftwareAgent.find_or_create_by(os: "OSX 10.9.0", browser: "Firefox")
      ip            = Ip.find_or_create_by(address: "63.29.38.211")
      client         =  Client.find_or_create_by({:identifier => "turing", :root_url => "http://turing.io"})
      parameter      =  Parameter.find_or_create_by({user_input: "#{i}"})

      PayloadRequest.find_or_create_by({
          :url_id => url.id,
          :requested_at => requested_at,
          :responded_in => 5,
          :request_type_id => request_type.id,
          :resolution_id => resolution.id,
          :referred_by_id => referrer.id,
          :software_agent_id => software_agent.id,
          :ip_id => ip.id,
          :parameter_id => parameter.id,
          :client_id => client.id })
    end
  end

  def create_payload3(integer)
    integer.times do |i|
      url           = Url.find_or_create_by(address: "http://galvanize.com/blog")
      requested_at  = Time.now
      request_type  = RequestType.find_or_create_by(verb: "POST")
      resolution    = Resolution.find_or_create_by(width: "1280", height: "80")
      referrer      = Referrer.find_or_create_by(address: "http://galvanize.com")
      software_agent = SoftwareAgent.find_or_create_by(os: "OSX 10.11.5", browser: "Chrome")
      ip            = Ip.find_or_create_by(address: "63.29.38.211")
      client         =  Client.find_or_create_by({:identifier => "galvanize", :root_url => "http://galvanize.com"})
      parameter      =  Parameter.find_or_create_by({user_input: "#{i}"})

      PayloadRequest.find_or_create_by({
          :url_id => url.id,
          :requested_at => requested_at,
          :responded_in => 10,
          :request_type_id => request_type.id,
          :resolution_id => resolution.id,
          :referred_by_id => referrer.id,
          :software_agent_id => software_agent.id,
          :ip_id => ip.id,
          :parameter_id => parameter.id,
          :client_id => client.id })
    end
  end

  def create_payload4(integer)
    integer.times do |i|
      url           = Url.find_or_create_by(address: "http://google.com/blog")
      requested_at  = Time.now
      request_type  = RequestType.find_or_create_by(verb: "POST")
      resolution    = Resolution.find_or_create_by(width: "1920", height: "1280")
      referrer      = Referrer.find_or_create_by(address: "http://google.com")
      software_agent = SoftwareAgent.find_or_create_by(os: "OSX 10.11.5", browser: "Chrome")
      ip            = Ip.find_or_create_by(address: "63.29.38.211")
      client         =  Client.find_or_create_by({:identifier => "google", :root_url => "http://google.com"})
      parameter      =  Parameter.find_or_create_by({user_input: "#{i}"})

      PayloadRequest.find_or_create_by({
          :url_id => url.id,
          :requested_at => requested_at,
          :responded_in => 20,
          :request_type_id => request_type.id,
          :resolution_id => resolution.id,
          :referred_by_id => referrer.id,
          :software_agent_id => software_agent.id,
          :ip_id => ip.id,
          :parameter_id => parameter.id,
          :client_id => client.id })
    end
  end

  def create_payload5(integer)
    integer.times do |i|
      url           = Url.find_or_create_by(address: "http://robohash.com/blog")
      requested_at  = Time.now
      request_type  = RequestType.find_or_create_by(verb: "PUT")
      resolution    = Resolution.find_or_create_by(width: "320", height: "568")
      referrer      = Referrer.find_or_create_by(address: "http://robohash.com#{i}")
      software_agent = SoftwareAgent.find_or_create_by(os: "OSX 10.11.5#{i}", browser: "Chrome#{i}")
      ip            = Ip.find_or_create_by(address: "63.29.38.211")
      client         =  Client.find_or_create_by({:identifier => "robohash", :root_url => "http://robohash"})
      parameter      =  Parameter.find_or_create_by({user_input: "#{i}"})

      PayloadRequest.find_or_create_by({
          :url_id => url.id,
          :requested_at => requested_at,
          :responded_in => 50 + i,
          :request_type_id => request_type.id,
          :resolution_id => resolution.id,
          :referred_by_id => referrer.id,
          :software_agent_id => software_agent.id,
          :ip_id => ip.id,
          :parameter_id => parameter.id,
          :client_id => client.id })
    end
  end
end

Capybara.app = RushHour::Server

class FeatureTest < Minitest::Test
  include Capybara::DSL
  include TestHelpers
end
