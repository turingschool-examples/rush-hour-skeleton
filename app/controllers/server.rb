module TrafficSpy


  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    post '/sources' do
      client = Client.new(name: params["identifier"], root_url: params["rootUrl"])
      ch = ClientHandler.new(client)
      status ch.status
      body ch.body
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
      paths = Payload.distinct.pluck(:path)
      @path_requested = @client.root_url + "/#{path}"

      if paths.include?(@path_requested)
        erb :url_details
      else
        @error_message = "That URL has not been requested."
        erb :error
      end
    end

    get '/sources/:identifier/events' do |identifier|
      @client = Client.find_by(name: identifier)


      if Payload.exists?(:event_name)
        erb :events_index
      else
        @error_message = "No events have been defined."
        erb :error
      end
    end

    get '/sources/:identifier/events/:event_name' do |identifier, event_name|
      @client = Client.find_by(name: identifier)

      if Payload.find_by(event_name: event_name)
        erb :event_details
      else
        @error_message = "That event isnt defined."
        erb :event_details_error, locals: {identifier: identifier}
      end
    end

    not_found do
      erb :error
    end
  end
end
