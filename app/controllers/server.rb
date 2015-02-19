require 'json'

module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    get '/sources' do
      erb :sources
    end

    post '/sources' do
      identifier = Identifier.new(name: params[:identifier], root_url: params[:rootUrl])

      if identifier.save
        body "{\"identifier\":\"#{params[:identifier]}\"}"
      else
        error_message = identifier.errors.full_messages.join(" ")
        status_number, message = MessageHelper.send_message(error_message)
        status status_number
        body message
      end
    end

    post '/sources/:identifier/data' do |identifier|
      unless Identifier.exists?(name: identifier)
        return status(400)
      end
      unless params[:payload]
        return status(400), body("Missing Payload - 400 Bad Request")
      end
      payload_hash = JSON.parse(params[:payload])
      Url.find_or_create_by(address: payload_hash["url"])
      status(200)
    end

    not_found do
      erb :error
    end

  end
end
