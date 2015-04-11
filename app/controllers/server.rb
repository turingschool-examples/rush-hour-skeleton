module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      status 200
      erb :index
    end

    post '/sources' do
      validation = ClientValidator.validate(params)
      status validation[:code]
      body validation[:message]
    end

    get '/sources' do
      clients = Client.all
      erb :sources, :locals => {:clients => clients}
    end

    get '/sources/:identifier' do |identifier|
      client = Client.find_by(identifier: identifier)
        if client.nil?
          erb :no_client_error
        else
          erb :client_main_page, :locals => {:client => client}
      end
    end

    post '/sources/:identifier' do |identifier|

    end

    get '/sources/registration_error' do

    end

    post '/sources/registration_error' do

    end

    get '/sources/:identifier/urls/:path/:rel_path' do |identifier, path, rel_path|
      sites = TrackedSite.find_by(url: "http://#{path}/#{rel_path}")
      erb :urls, :locals => {sites: sites}
    end

    post '/sources/:identifier/urls/:path' do |identifier, path|

    end

    get '/sources/:identifier/urls/url_error' do |identifier|

    end

    post '/sources/:identifier/urls/url_error' do |identifier|

    end

    get '/sources/:identifier/events' do |identifier|

    end

    post '/sources/:identifier/events' do |identifier|

    end

    get '/sources/:identifier/no_events_error' do |identifier|

    end

    post '/sources/:identifier/no_events_error' do |identifier|

    end

    get '/sources/:identifier/events/:event_name' do |identifier, event_name|
      @event_id = Event.find_by(event_name: event_name).id
      @client = Client.find_by(identifier: identifier)
      binding.pry
      erb :client_main_page
    end

    post '/sources/:identifier/events/:event_name' do |identifier, event_name|

    end

    get '/sources/:identifier/events/event_name_error' do |identifier|

    end

    post '/sources/:identifier/events/event_name_error' do |identifier|

    end

    post '/sources/:identifier/data' do |identifier|
      @payload = PayloadValidator.validate(params["payload"], identifier)
      status @payload[:code]
      body @payload.fetch(:message, nil)
    end

    not_found do
      erb :error
    end
  end
end
