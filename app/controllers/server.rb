require 'json'
require 'byebug'

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

    post '/sources/:identifier/data' do |identifier|
      payload_hash = JSON.parse(params[:payload])
      if PayloadHelper.source_exists?(identifier)
        payload = PayloadHelper.add_payload(identifier, payload_hash)
        if PayloadHelper.duplicate_source?(payload)
          status 403
          body "Already Received Request"
        elsif payload.save
          status 200
          body "OK"
        else
          status 400
          body "Payload can't be blank"
        end
      else
        status 403
        body "Application not registered"  
      end
    end
  end
end
