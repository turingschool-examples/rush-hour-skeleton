module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    get '/sources' do
      @sources = Source.all
      erb :sources
    end

    post '/sources' do
      saved_source = Source.new(identifier: params[:identifier], root_url: params[:rootUrl])
      status, body = Validator.validate_source(saved_source)
    end

    get "/sources/:identifier" do |identifier|
      if Validator.validate_url(identifier) == false
        erb :identifier_error
      else
        @source = Source.where(identifier: identifier).first
        erb :application_details
      end
    end

    post "/sources/:identifier/data" do |identifier|
      @source = Source.find_by(identifier: identifier)
      payload = Payload.new(Validator.prepare_payload(params["payload"]))
      Validator.add_source_id(payload, @source)
      status, body = Validator.validate_payload(identifier, payload, @source)
    end

    get "/sources/:identifier/urls/:rel_path" do |identifier, rel_path|
      if Validator.validate_url(identifier) == false
        erb :url_error
      else
        @source = Source.find_by(identifier: identifier)
        payload = Payload.where(source_id: @source.id)
        relative_path = "#{@source.root_url}/#{rel_path}"
        @relevant_payloads = payload.where(url: relative_path)
        erb :url_statistics
      end
    end

    get "/sources/:identifier/events" do |identifier|
      @source = Source.find_by(identifier: identifier)
      payload = Payload.where(source_id: @source.id)
      if Validator.validate_events(identifier) == true || payload.empty?
        erb :event_error
      else
        @events = payload.group(:event_name).count.sort_by { |url, count| count }.reverse
        erb :event_data
      end
    end

    get "/sources/:identifier/events/:event_name" do |identifier, event_name|
      @source = Source.find_by(identifier: identifier)
      @payload = Payload.where(source_id: @source.id).where(event_name: event_name)
      if Validator.validate_events(identifier) == true || @payload.empty?
        erb :no_event_error
      else
        @event_name = event_name
        erb :event_specific_data
      end
    end

    not_found do
      erb :error
    end
  end
end
