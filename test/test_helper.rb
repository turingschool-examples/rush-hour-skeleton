ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'
require 'database_cleaner'
require 'rack/test'


Capybara.app = RushHour::Server

DatabaseCleaner.strategy = :truncation, {except: %w([public.schema_migrations])}

module TestHelpers
  include Rack::Test::Methods

  def setup
    DatabaseCleaner.start

    @url = Url.create({:name=> "http://jumpstartlab.com/blog"})
    @referrer = Referrer.create({:name => "http://jumpstartlab.com"})
    @request_type = RequestType.create({:verb => "GET"})
    @event_name = EventName.create({:name => "socialLogin"})
    @user_agent = UserAgent.create({:browser => "Mozilla", :platform => "Macintosh"})
    @resolution = Resolution.create({:width => "1920", :height => "1280"})
    @ip = Ip.create({:value => "63.29.38.211"})

    @payload = PayloadRequest.create({
      :url_id => url.id,
      :referrer_id => referrer.id,
      :request_type_id => request_type.id,
      :requested_at => "2013-02-16 21:38:28 -0700",
      :event_name_id => event_name.id,
      :user_agent_id => user_agent.id,
      :responded_in => 37,
      :parameters => [],
      :ip_id => ip.id,
      :resolution_id => resolution.id
      })

  end

  def teardown
    DatabaseCleaner.clean
  end

end
