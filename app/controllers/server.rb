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

    post '/sources/:identifier/data' do |identifier|
      data = PayloadParser.parse(params)
      @payload = PayloadValidator.validate(data)
      status @payload[:code]
      body @payload.fetch(:message, nil)
    end

    not_found do
      erb :error
    end
  end
end
