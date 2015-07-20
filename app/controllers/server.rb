require 'json'
require 'uri'
module TrafficSpy

  class Server < Sinatra::Base
    get '/' do
      @identifier = params[:identifier]
      erb :index
    end


    get '/sources' do
      erb :new
    end

    get '/sources/:identifier' do
      app_handler = AppDataHandler.new(params[:identifier])
      if app_handler.registration.nil?
        @message = app_handler.message
        erb app_handler.erb
      else
        @urls = app_handler.url_stats
        @browsers = app_handler.browser_stats
        @os = app_handler.os_stats
        @resolutions = app_handler.resolution_stats
        @avg_response_times = app_handler.response_times
        @links = app_handler.link_list
        @link_paths = app_handler.link_paths
        erb :identifier_index
      end
    end

    not_found do
      erb :error
    end

    post '/sources' do
      sources_handler = RegistrationHandler.new(params)
      status sources_handler.status
      body sources_handler.body
    end

    post "/sources/:identifier/data" do |identifier|
      data_handler = DataProcessingHandler.new(params, identifier)
      status data_handler.status
      body data_handler.body
    end


    get '/sources/:identifier/urls/:path' do |identifier, path|
      @registration = Registration.find_by(:identifier => params[:identifier])
      urls_handler = UrlStatisticsHandler.new(identifier, path)
      @url = urls_handler.url
      @message = urls_handler.message
      erb urls_handler.erb
    end


    get '/sources/:identifier/events' do |identifier|
      registration = Registration.find_by(:identifier => identifier)

      if registration.nil?
        redirect '/not_found'
      else
        @events_by_popularity = registration.events.group(:name).order('count_name desc').count(:name)
        erb :events
      end

    end


    get '/sources/:identifier/events/:event_name' do |identifier, event_name|
      @identifier = identifier
      registration = Registration.find_by(:identifier => @identifier)

      if registration.nil?
        redirect '/not_found'
      else
        @event_name = event_name
        @event_total = registration.events.group(:name).count(:name)
        @event_by_times = registration.events.where(:name => @event_name).group(:requested_at).order('requested_at asc').count('requested_at')
        erb :event
      end

    end

  end
end
