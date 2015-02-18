module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    get '/sources' do
      erb :sources
    end

    post '/sources' do
      identifier = Identifier.new(params)
      if identifier.save
        body "created"
      else
        status 400
        body identifier.errors.full_messages.join("\n")
      end
    end

    not_found do
      erb :error
    end
  end
end
