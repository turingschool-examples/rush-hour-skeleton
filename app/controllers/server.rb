require 'json'
require 'uri'
module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    get '/sources' do
      erb :new
    end

    get '/sources/:identifier' do
      registration = Registration.find_by(:identifier => params[:identifier])
      identifier = params[:identifier]
      if registration.nil?
        @message = "The #{identifier} identifier does not exist"
        erb :identifier_error
      else
        url_hash = registration.urls
        @urls = url_hash.map do |key, value|
          if !key.nil?
            [value, key[:url]]
          end
        end.compact.sort.reverse

        browser_hash = registration.browsers
        @browsers = browser_hash.map do |key, value|
          if !key.nil?
            [value, key[:name]]
          end
        end.compact.sort.reverse

        @os = registration.operating_systems.map do |key, value|
          if !key.nil?
            [value, key[:name]]
          end
        end.compact.sort.reverse

        @resolutions = registration.screen_resolutions.map do |key, value|
          if !key.nil?
            [value, key[:width],key[:height]]
          end
        end.compact.sort.reverse

        @avg_response_times = registration.events.average(:responded_in)
        @long_response_times = registration.events.maximum(:responded_in)
        @short_response_times = registration.events.minimum(:responded_in)

        @links = registration.urls.map do |key, value|
          if !key.nil?
            [key[:url]]
          end
        end.compact

        @link_paths = @links.map do |link|
          URI(link.join).path

        end
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
      @message = urls_handler.message
      erb urls_handler.erb
    end

  end
end
