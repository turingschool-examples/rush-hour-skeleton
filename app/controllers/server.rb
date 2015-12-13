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

    get '/sources/:identifier/' do |identifier|
      @client = Client.find_by(name: identifier)
      @error_message = ViewHandler.assign_application_details_error_message(@client)
      erb ViewHandler.assign_application_details_erb_path(@client)
    end

    get '/sources/:identifier/urls/:path' do |identifier, path|
      @client = Client.find_by(name: identifier)
      @path_requested = @client.root_url + "/#{path}"
      @error_message = ViewHandler.assign_url_details_error_message(@path_requested)
      erb ViewHandler.assign_url_details_erb_path(@path_requested)
    end

    get '/sources/:identifier/events' do |identifier|
      @client = Client.find_by(name: identifier)
      @error_message = ViewHandler.assign_events_index_error_message(@client)
      erb ViewHandler.assign_events_index_erb_path(@client)
    end

    get '/sources/:identifier/events/:event_name' do |identifier, event_name|
      @client = Client.find_by(name: identifier)
      @error_message = ViewHandler.assign_event_details_error_message(event_name)
      erb ViewHandler.assign_event_details_erb_path(event_name), locals: {identifier: identifier, event_name: event_name}
    end

    not_found do
      erb :error
    end
  end
end
