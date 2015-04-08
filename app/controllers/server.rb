module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      status 200
      erb :index
    end

    post '/sources' do
      # require 'pry';binding.pry
      validation = ClientValidator.validate(params)
      status validation[:code]
      body validation[:message]
    end

    post '/sources/:identifier/data' do |identifier|
      require 'pry'; binding.pry
      data = PayloadParser.parse(params)
      @payload = PayloadValidator.validate(data)
      # @client_id = Client.where(identifier: identifier).select(:id).first.id
      # @client = Client.where(name: identifier).id
      status @payload[:code]
    end

    not_found do
      erb :error
    end
  end
end
