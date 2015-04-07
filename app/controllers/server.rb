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
      if Source.find_by(identifier: source.identifier)
        status 403
        body "Identifier already exists"
      elsif source.save
        status 200
        body JSON.generate({ :identifier => source.identifier })
      else
        status 400
        body source.errors.full_messages
      end
    end
  end
end
