module TrafficSpy
  class Server < Sinatra::Base
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

    get "/sources/:identifier" do |identifier|
      source = Source.all.find_by(identifier: identifier)
      @payload = Payload.find_by(source_id: source.id)
      erb :application_details
    end

    post "/sources/:identifier/data" do |identifier|
      @source = Source.find_by(:identifier => identifier)
      payload = Payload.new(Validator.prepare_payload(params["payload"]))
      status, body = Validator.validate_payload(identifier, payload, @source)
    end

    not_found do
      erb :error
    end
  end
end
