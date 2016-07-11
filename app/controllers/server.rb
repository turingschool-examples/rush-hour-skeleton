module RushHour
  class Server < Sinatra::Base

    not_found do
      send_error("Error")
    end

    post '/sources' do
      client = Client.new(identifier: params[:identifier], root_url: params[:rootUrl])
      if Client.exists?(identifier: params[:identifier])
        status 403
        body  "Identifier has already been taken"
      elsif client.save
        status  200
        body "Client created"
      else
        status 400
        body client.errors.full_messages.join(", ")
      end
    end

    post '/sources/:identifier/data' do |identifier|

      client = Client.find_by(identifier: identifier)
      payload = DataParser.new(params[:payload]).parse_payload(identifier) unless params[:payload].nil? || client.nil?
      if client.nil? #!Client.where(identifier: identifier) #
        status 403
        body "Application has not been registered"
        #body #payload.errors.full_messages
      elsif payload.nil?
        status 400
        body "Payload cannot be blank"
      elsif payload.save
        status 200
        body "Payload received"
      else #payload.errors.full_messages.include?("has already been received")
        status 403
        body "Payload has already been received"
        #body #payload.errors.full_messages
      end
    end

    get '/sources/:identifier' do |identifier|
      client = Client.find_by(identifier: identifier)
      if client.nil?
      #!Client.where(identifier: identifier)
        send_error("Client does not exist")
      elsif Client.where(identifier: identifier)
        @client = Client.find_by(identifier: identifier)
        erb :show
        #   #goes to their endpoint and they can view statistics
      elsif Client.where(identifier: identifier) && PayloadRequest.where(client_id: client)
        body "Please submit your payload request."
      end
    end

    get '/' do
      erb :index
    end

    get '/sources/:identifier/urls/:relative_path' do |identifier, relative_path|
      client = Client.find_by(identifier: identifier)
      # if client.nil?
      #   erb :error
      # elsif client
      #   erb :url
        @client.urls.find_specific_url(relative_path)

      # @url = client.urls.find_by(path: params[:relative_path])
      # specific_path = @client.urls.find_specific_url(relative_path)
      # if specific_path.nil?
      #   send_error("That URL has not been requested")
      # elsif client.url.exists?
      #   erb :"#{:identifier}/urls/#{:relative_path}"
        # verb_list_for_url
      end
    end

    def send_error(body)
      body = @error
      erb :error
    end

  end
