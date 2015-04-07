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
      source = Source.new(root_url: params["rootUrl"], identifier: params["identifier"])
      if source.save
        status 200
        body "success"
      else
        status 400
        body source.errors.full_messages
      end
    end
  end
end


#attributes = JSON.parse(params)

#get out idendifier 