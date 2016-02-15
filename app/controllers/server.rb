module RushHour

  class Server < Sinatra::Base
    not_found do
      erb :error
    end

    get '/' do
      erb :home
    end

    post '/sources' do
      @client = Client.new(:root_url => params["rootUrl"], :identifier => params["identifier"])
      if @client.save
        status 200
        body "{\"identifier\":\"#{@client.identifier}\"}"
      elsif params["rootUrl"].nil? || params["identifier"].nil?
        status 400
        body "Missing Parameters"
      else
        status 403
        body @client.errors.full_messages.join(", ")
      end
    end

    post '/sources/:identifier/data' do |identifier|
      code, message = RequestParser.parse_request(params["payload"], identifier)
      status(code)
      body(message)
    end

    get '/sources/:identifier/urls/:relative_path' do |identifier, relative_path|
      @client = Client.where(identifier: identifier).first
      url = @client.root_url + '/' + relative_path
      unless Url.pluck(:address).include?(url)
        redirect '/missing-url'
      else
        @url_obj = Url.where(address: url).first
        erb :url_stats
      end
    end

    get '/missing-url' do
      erb :unrequested_url
    end

    get '/sources/:identifier' do |identifier|
      @client = Client.where(identifier: identifier).first
      @payloads = PayloadRequest.where(client_id: @client.id) if !@client.nil?
      @user_systems = UserSystem.where(id: @payloads.pluck(:user_system_id)) if !@client.nil?
      @resolutions = Resolution.where(id: @payloads.pluck(:resolution_id)) if !@client.nil?
      
      erb PathParser.sources_identifier_parse(@payloads, @client)
    end

    get 'sources/:identifier/events/:event_name' do |identifier, event_name|
      @client = Client.where(identifier: identifier).first
      @payloads = PayloadRequest.where(client_id: @client.id)
      @events = EventName

      erb :event_breakdown
    end
  end
end
