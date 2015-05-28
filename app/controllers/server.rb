require 'pry'
require_relative '../models/source_creator'
require 'json'

module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    not_found do
      erb :error
    end
    
    post '/sources' do
      result = SourceCreator.new
      result.result(params)
      status(result.status)
      body(result.body)
    end

    post "/sources/:identifier/data" do |identifier|
      return status 403 unless Source.all.any? { |s| s.identifier == identifier }
      return status 400 if params[:payload].nil?
      payload_data = JSON.parse(params[:payload])
      payload = Payload.new(requested_at: payload_data["requestedAt"])
      if payload.save
        status 200
      else
        status 403
      end
    end
  end
end

