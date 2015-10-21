module TrafficSpy
  class Server < Sinatra::Base
    require 'json'
    get '/' do
      erb :index
    end

    get '/sources' do
      erb :sources
    end

    post '/sources' do
      source = Source.new({identifier: params[:identifier], root_url: params[:rootUrl]})
      status, body = Validator.validate_source(source)
    end

    post "/sources/:identifier/data" do |identifier|
      @source = Source.find_by(:identifier => identifier)
      raw_payload = params[:payload]
      payload = JSON.parse(raw_payload)
      Payload.create(payload)
    end

    get "/sources/:identifier/data" do |identifier|

    end

    not_found do
      erb :error
    end
  end
end
