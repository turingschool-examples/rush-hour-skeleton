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
      p = params
      require 'pry'; binding.pry
      status 200
    end

    not_found do
      erb :error
    end
  end
end
