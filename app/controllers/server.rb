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
      # response = PayloadCreator.new(params, identifier)
      # status(response.status)
      # body(response.body)

      result = PayloadCreator.new
      result.result(params, identifier)
      status(result.status)
      body(result.body)
    end

    get "/sources/:identifier" do |identifier|
      if Source.where(identifier: identifier).exists?
        @source = Source.find_by(identifier: identifier)
        erb :dashboard
      else
        message = "oops"
        redirect to("/?message=#{message}")
      end
    end
  end
end
