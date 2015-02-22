module TrafficSpy
  class Server < Sinatra::Base

    get '/' do
      erb :index
    end

    post '/sources' do
      # pull this out into its own model
      source = Source.new(params)
      if source.save
        status 200
        body source.simplified_json
      else
        status_helper = StatusHelper.new(source.error_response)
        status status_helper.status
        body source.error_response
      end
    end

    get '/sources/:identifier' do |identifier|
      @identifier = identifier
      source = Source.find_by(identifier: identifier)
      if source
        @payloads = source.payloads
        @urls           = Url.all
        @user_agents    = PayloadUserAgent.all
        @resolutions    = Resolution.all
        @response_times = Payload.all.map { |payload| payload.responded_in }
        erb :app_details
      else
        erb :unregistered_user
      end
    end

    get '/sources/:indentifier/events/:EVENTNAME' do
      #add sad path page if event is not defined
      #link back to events index page
      erb :app_event_details
    end

    post '/sources/:identifier/data' do |identifier|
      payload_generator = PayloadGenerator.call(params[:payload], identifier)
      status payload_generator.status
      body   payload_generator.message
    end

    not_found do
      erb :error
    end
  end
end
