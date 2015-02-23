module TrafficSpy
  class Server < Sinatra::Base

    get "/" do
      erb :index
    end

    post "/sources" do
      identifier_generator = IdentifierGenerator.call(params)
      status identifier_generator.status
      body   identifier_generator.message
    end

    post "/sources/:identifier/data" do |identifier|
      payload_generator = PayloadGenerator.call(params[:payload], identifier)
      status payload_generator.status
      body   payload_generator.message
    end

    get "/sources/:identifier" do |identifier|
      source = Source.find_by(identifier: identifier)
      if source
        @payloads       = source.payloads
        @urls           = Url.all
        @relative_paths = Payload.relative_url_paths
        @user_agents    = PayloadUserAgent.all
        @resolutions    = Resolution.all
        @response_times = Payload.response_times
        @identifier     = identifier
        erb :app_details
      else
        erb :unregistered_user
      end
    end

    get '/sources/:identifier/events' do
      @source = Source.find_by!(identifier: params[:identifier])
      events_by_source = @source.payloads.map {|payload| payload.event }
      @events = events_by_source.inject(Hash.new(0)) {|sum,event| sum[event]+=1; sum }.sort_by {|k,v| -v}
      @relative_paths = Payload.relative_url_paths
      @identifier = params[:identifier]
      erb :event_index
    end

    get "/sources/:indentifier/events/:EVENTNAME" do
      #add sad path page if event is not defined
      #link back to events index page
      erb :event_details
    end

    get "/sources/:identifier/urls/*" do
      if Source.exists?(identifier: params[:identifier])
        validate_url
      else
        erb :unregistered_user
      end
    end

    not_found do
      erb :error
    end

  private

    def root_url
      Source.find_by(identifier: params[:identifier]).root_url
    end

    def address
      Url.create_url(root_url, params[:splat].join("/"))
    end

    def validate_url
      @created_address = address
      if !Url.exists?(address: address)
        status 400
        erb :url_error
      else
        url_stats
        erb :url_statistics
      end
    end

    def url_stats
      @longest_response  = Url.longest_response(@created_address)
      @shortest_response = Url.shortest_response(@created_address)
      @average_response  = Url.average_response(@created_address)
      @http_verbs        = Url.http_verbs(@created_address)
      @pop_referrer      = Url.popular_referrer(@created_address)
      @pop_agent         = Url.popular_user_agent(@created_address)
      @relative_paths    = Payload.relative_url_paths
      @identifier        = params[:identifier]
    end

  end
end
