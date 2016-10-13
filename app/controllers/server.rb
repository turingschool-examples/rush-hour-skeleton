module RushHour
  class Server < Sinatra::Base
    not_found do
      erb :error
    end

    get '/' do

    end

    get '/sources' do
      @clients = Client.all

    end

    post '/sources' do
      client = Client.new("identifier" => params[:identifier], "root_url" => params[:rootUrl])
      if params[:identifier].nil? || params[:rootUrl].nil?
        [400, "Bad Request: Please include both an identifer and root url."]
      elsif Client.exists?(:identifier => params[:identifier])
        [403, "Forbidden: That identifier is already in use. Please choose a new identifier."]
      else
        client.save
        [200, "Success: {'identifier':#{params[:identifier]}}"]
      end
    end

    get '/sources/:identifier' do |identifier|
      @client = Client.find_by(identifier: identifier)
      @identifier = identifier
      if @client.nil?
        erb :error_no_client
      elsif Payload.where(client_id: @client.id).empty?
        erb :error_no_payload
      else
        @urls = @client.urls
        erb :show_client
      end
    end

    get '/sources/:identifier/events_index' do |identifier|
      @identifier = identifier
      client = Client.find_by(identifier: identifier)
      @events = client.events
      erb :events_index
    end

    post '/sources/:identifier/data' do |identifier|
      if params[:payload].nil?
        [400, "Missing Payload"]
      elsif !Client.exists?(:identifier => identifier)
        [403, "Application not registered"]
      else
        parsed_data = PayloadParser.parser(params[:payload])
        payload = PayloadBuilder.build(parsed_data, identifier)
        if payload.new_record?
          payload.save
          [200, "Yay"]
        else
          [403, "Already received request"]
        end
      end
    end

    get '/sources/:identifier/urls/:relativepath' do |identifier, relativepath|
      @identifier = identifier
      @relative_path = relativepath
      client = Client.find_by(identifier: identifier)
      @full_url = (client.root_url + "/" + relativepath) if !client.nil?
      if client.nil?
        erb :error_no_client
      elsif !client.urls.find_by(url_address: @full_url)
        erb :error_no_url
      else
        @url = client.urls.find_by(url_address: @full_url)
        erb :show_url
      end
    end

    get '/sources/:identifier/events/:eventname' do |identifier, eventname|
      client = Client.find_by(identifier: identifier)
      @identifier = identifier
      if client.nil?
        erb :error_no_client
      elsif !client.events.find_by(event_name: eventname)
        erb :error_no_event
      else
        @event_name = eventname
        @events = client.events.where(event_name: eventname)
        id = @events.first.id
        event_payloads = client.payloads.where(event_id: id)
        @grouped_times = event_payloads.group_by { |payload|  payload.requested_at.hour }
        erb :show_event
      end
    end

  end
end
