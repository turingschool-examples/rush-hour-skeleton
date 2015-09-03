module TrafficSpy
  class Server < Sinatra::Base

    get '/' do
      erb :index
    end

    post '/sources' do
      messenger = Messenger.new(params, "Source")
      status messenger.status
      body messenger.message
    end

    post '/sources/:identifier/data' do
      messenger = Messenger.new(params, "Visit")
      status messenger.status
      body messenger.message
    end

    not_found do
      erb :error
    end
  end
end
