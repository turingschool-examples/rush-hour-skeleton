require 'pry'

module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    post '/sources' do
      source = Source.new(params)
      if source.save
        status 200
        body source.simplified_json
      else
        status 400
        body source.error_response
      end
    end

    not_found do
      erb :error
    end

  end
end
