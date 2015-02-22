module TrafficSpy
  class Server < Sinatra::Base

    get '/' do
      erb :index
    end

    post '/sources' do
      identifier_generator = IdentifierGenerator.call(params)
      status identifier_generator.status
      body   identifier_generator.message
    end

    post '/sources/:identifier/data' do |identifier|
      payload_generator = PayloadGenerator.call(params[:payload], identifier)
      status payload_generator.status
      body   payload_generator.message
    end

    get '/sources/:identifier' do |identifier|
      source = Source.find_by(identifier: identifier)
      if source
        @payloads       = source.payloads
        @urls           = Url.all
        @relative_paths = Payload.relative_url_paths
        @user_agents    = PayloadUserAgent.all
        @resolutions    = Resolution.all
        @response_times = Payload.response_times
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

    not_found do
      erb :error
    end
  end
end
