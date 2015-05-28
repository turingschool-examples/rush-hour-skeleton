require 'pry'
require_relative '../models/source_creator'

module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    post '/sources' do
      result = SourceCreator.new
      result.result(params)
      status(result.status)
      body(result.body)
    end

    not_found do
      erb :error
    end
  end
end

