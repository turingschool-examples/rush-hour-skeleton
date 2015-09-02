module TrafficSpy
  class Server < Sinatra::Base

    get '/' do
      erb :index
    end

    post '/sources' do
      messenger = SourceMessenger.new(params)
      status messenger.status
      body messenger.message
    end

    not_found do
      erb :error
    end
  end
end
