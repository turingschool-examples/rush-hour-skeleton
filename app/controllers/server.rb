module TrafficSpy


  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    post '/sources' do
      client = Client.new(name: params["identifier"], root_url: params["rootUrl"])
        #save here
      #pass params to Validator

      if Client.find_by(name: params["identifier"])
        status 403
        body "Name already taken."
      elsif client.save
        body "Client created."
      else
        status 400
        body "Missing parameters."
        # client.errors.full_messages
      end
    end

    post '/sources/:identifier/data' do |identifier|
      ph = PayloadHandler.new(params)
      status ph.status
      body ph.body
    end

    get '/sources/:identifier' do |identifier|
      @client = Client.find_by(name: identifier)
      if @client && !@client.payloads.empty?
        erb :application_details
      elsif @client && @client.payloads.empty?
        @error_message = "No payload data has been received for this source."
        erb :error
      else
        @error_message = "The identifier does not exist."
        erb :error
      end
    end

    get '/sources/:identifier/urls/:path' do |identifier, path|
      @client = Client.find_by(name: identifier)
      binding.pry
      if Payload.distinct.pluck(:path).include?(@client.root_url + "/#{path}")
        puts "THIS SHIT EXISTS"
        # erb :url_details
      else
        @error_message = "That URL has not been requested."
        erb :error
      end
    end

    not_found do
      erb :error
    end
  end
end
