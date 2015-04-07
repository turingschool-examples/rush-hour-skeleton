require 'json'

module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    not_found do
      erb :error
    end

    post '/sources' do 
      attributes = JSON.parse(params)
      source = Source.new(attributes)
    end
  end
end


#attributes = JSON.parse(params)

#get out idendifier 