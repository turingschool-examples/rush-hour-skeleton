require 'pry'

module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    not_found do
      erb :error
    end
    
    post '/sources' do
      source = Source.new(identifier: params[:identifier], root_url: params[:rootUrl])
      # binding.pry
      if source.save
        status 200
        body "{'identifier':'jumpstartlab'}"
      else
        status 400
        body source.errors.full_messages.join
      end
    end
  end
end

