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
      url_hash = Payload.all.group(:url).count
      @urls = url_hash.map do |key, value|
        if !key.nil?
          [value, key[:url]]
        end
      end.compact.sort.reverse
      erb :identifier_index
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
  end
end
