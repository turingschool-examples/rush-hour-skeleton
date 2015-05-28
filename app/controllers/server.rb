require  'digest/sha1'
require 'pry'

module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    get '/sources' do

    end

    post '/sources' do
      source = Source.new(identifier: params[:identifier], rooturl: params[:rootUrl])
      if source.save
        status 200
        body "{'identifier':'#{source.identifier}'}"   #"Registration complete."
      elsif source.errors.full_messages.include?("Identifier has already been taken")
        status 403
        body source.errors.full_messages
      else
        status 400
        body source.errors.full_messages
      end
      # params (identifier rooturl)
      # curl -i -d 'identifier=(thing)&rooturl=(thing)' http://ourapp:port/sources
    end

    post '/sources/:identifier/data' do |identifier|
      # identifier.insert(-2, ",\"payhash\":\"#{Digest::SHA1.hexdigest(identifier)}\”")
      # binding.pry

      yyy = Digest::SHA1.hexdigest(params[:payload])

      x = Source.find_by_identifier(identifier)
      if x == Source.find_by_identifier(identifier)
        if x.payloads.find_by_payhash(yyy) #looking for payloads that match this source
          status 403
          body "Already Exists"
        else
          x.payloads.create(payhash: yyy)
          status 200
        end
      else
        status 403
        "Application Not Registered"
      end
    end

    not_found do
      erb :error
    end
  end
end

