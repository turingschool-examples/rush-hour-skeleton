module TrafficSpy
  class Server < Sinatra::Base
    require 'json'
    require 'digest'

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
      @source = Source.all.find_by(identifier: identifier)
      @payload = Payload.where()
      erb :application_details
    end

    post "/sources/:identifier/data" do |identifier|
      @source = Source.find_by(:identifier => identifier)
      raw_payload = params[:payload]
      payload = JSON.parse(raw_payload)
      payload["unique_hash"] = Digest::SHA2.hexdigest(raw_payload)
      parsed_payload = Payload.new(payload)
      parsed_payload.update_attribute("source_id", @source.id)
      status, body = Validator.validate_payload(identifier, parsed_payload)
    end


    not_found do
      erb :error
    end
  end
end
