require_relative '../test_helper'

class ClientEnvironmentSimulator < Minitest::Test

  def initialize
    @client = ["jumpstartlab", "google", "metacritic", "binglol"]
    @client_url = ["images", "blog", "store", "fun_stuff"]
    @request_type = ["GET", "POST"]
    @event_name = ["Social", "Dog", "Dad?", "ComputerStuff"]
    @user_agent = ["Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17", "Chrome/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17", "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) YELLOW!/24.0.1309.0 Safari/537.17"]
    @resolution = [[10000, 12000], [500, 800], [15000, 20000]]
    @ip = ["63.29.38.211", "64.92.38.211", "14.92.38.300"]
    @referred_by = ["http://dogs.com", "http://pretzels.com", "http://wheeeeee.com", "http://yellow.com", "http://google.com"]
  end


  def start_simulation
    client_registration

    30.times do
      client_request
    end
  end


  def client_registration
    @client.each do |client|
      post '/sources', "identifier=#{client}&rootUrl=http://#{client}.com"
    end
  end

  def client_request
    resolution = @resolution.sample
    client = @client.sample
    payload_data = {"url": "http://#{client}.com/#{@client_url.sample}",
                    "requestedAt": "#{rand(2014..2015)}-#{rand(1..12)}-#{rand(1..30)} #{rand(0..24)}:#{rand(0..60)}:#{rand(0..60)} -#{rand(0..2400)}",
                    "respondedIn": rand(0..30),
                    "referredBy": "#{@referred_by.sample}",
                    "requestType": "#{@request_type.sample}",
                    "parameters": [],
                    "eventName": "#{@event_name.sample}",
                    "userAgent": "#{@user_agent.sample}",
                    "resolutionWidth": "#{resolution[0]}",
                    "resolutionHeight": "#{resolution[1]}",
                    "ip": "#{@ip.sample}"}.to_json


    post "/sources/#{client}/data", {payload: payload_data}
  end


end
