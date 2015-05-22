require 'byebug'

module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    not_found do
      erb :error
    end

    post '/sources' do
      parsed_source = IdentifierParser.validate(params)
      status parsed_source.status
      body parsed_source.body
    end

    post '/sources/:identifier/data' do |identifier|
      json_parsed = JSON.parse(params['payload'])
      parsed_payload = PayloadParser.validate(json_parsed, identifier)
      status parsed_payload.status
      body parsed_payload.body
    end

    get '/source/:identifier' do |identifier|
      @identifier = identifier
      @source = Source.find_by(identifier: identifier)

      if @source.nil?
        erb :error
      else
        erb :show
      end
    end

  end

end
