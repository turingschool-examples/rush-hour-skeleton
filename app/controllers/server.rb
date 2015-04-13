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
      if client
        erb :client_main_page, :locals => {:client => client}
      else
        erb :no_client_error
      end
    end

    get '/sources/:identifier/urls/:path' do |identifier, path|
      client    = Client.find_by(identifier: identifier)
      site      = TrackedSite.find_by(url: "#{client.root_url}/#{path}")
      full_path = "#{client.root_url}/#{path}"
      if site
        erb :urls, :locals => {site: site, client: client, path: full_path}
      else
        erb :urls_error
      end
    end

    get '/sources/:identifier/events' do |identifier|
      client = Client.find_by(identifier: identifier)
      if client.ordered_most_to_least_events.empty?
        erb :no_events, :locals => {client: client}
      else
        erb :events, :locals => {client: client}
      end
    end

    get '/sources/:identifier/events/:event_name' do |identifier, event_name|
      event  = Event.find_by(event_name: event_name)
      client = Client.find_by(identifier: identifier)
      erb :event_details, :locals => {event: event, client: client}
    end

    post '/sources/:identifier/data' do |identifier|
      payload = params["payload"] ||= nil
      payload_data = PayloadValidator.validate(payload, identifier)
      status payload_data[:code]
      body payload_data.fetch(:message, nil)
    end

    not_found do
      erb :error
    end
  end
end
