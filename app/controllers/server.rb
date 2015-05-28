require 'pry'
require_relative '../models/source_creator'

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
      binding.pry
    end
  end
end

