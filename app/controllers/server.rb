module RushHour
  # include Handler

  class Server < Sinatra::Base

    not_found do
      send_error("Error")
    end

    post '/sources' do
      # client = Client.new(identifier: params[:identifier], root_url: params[:rootUrl])
      #   status Handler.post_to_sources(client, params)[:status]
      #   body Handler.post_to_sources(client, params)[:body]
      client = Client.new(identifier: params[:identifier], root_url: params[:rootUrl])
      if Client.exists?(identifier: params[:identifier])
        status 403
        body  "Identifier has already been taken"
      elsif client.save
        status  200
        body "{identifier: '#{client.identifier}'}"
      else
        status 400
        body client.errors.full_messages.join(", ")
      end
    end

    post '/sources/:identifier/data' do |identifier|
      client = Client.find_by(identifier: identifier)
      payload_request = DataParser.new(params[:payload]).parse_payload(identifier) unless params[:payload].nil? || client.nil?
      # status Handler.post_with_payload(client, payload_request, params)[:status]
      # body Handler.post_with_payload(client, payload_request, params)[:body]
      if client.nil?
        status 403
        body "Application has not been registered"
      elsif payload_request.nil?
        status 400
        body "Payload cannot be blank"
      elsif payload_request.validates?
        status 200
        body "Payload received"
      else
        status 403
        body "Payload has already been received"
      end
    end

    get '/sources/:identifier' do |identifier|
      client = Client.find_by(identifier: identifier)
      if client.nil?
        send_error("Client does not exist")
      elsif Client.where(identifier: identifier)
        @client = Client.find_by(identifier: identifier)
        erb :show
      elsif Client.where(identifier: identifier) && PayloadRequest.where(client_id: client)
        body "Please submit your payload request."
      end
    end

    get '/' do
      erb :index
    end

    get '/sources/:identifier/urls/:relative_path' do |identifier, relative_path|
      @client = Client.find_by(identifier: identifier)
        @specific_path = @client.urls.find_by(path: "#{'/'}"+relative_path)
      if @specific_path.nil?
        send_error("That URL has not been requested")
      else
         erb :specific_path
      end
    end

    def send_error(body)
      body = @error
      erb :error
    end

  end
end
