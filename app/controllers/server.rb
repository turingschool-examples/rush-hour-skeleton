require 'json'
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
        url_hash = registration.payloads.group(:url).count
        @urls = url_hash.map do |key, value|
          if !key.nil?
            [value, key[:url]]
          end
        end.compact.sort.reverse
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

    get '/sources/:identifier/urls/:relative' do |identifier, relative|
      urls_handler = UrlStatisticsHandler.new(identifier, relative)
      @message = urls_handler.message
      erb urls_handler.erb
    end

    get '/sources/:identifier/urls/:relative/:path' do |identifier, relative, path|
      urls_handler = UrlStatisticsHandler.new(identifier, relative, path)
      @message = urls_handler.message
      erb urls_handler.erb
    end

  end
end
