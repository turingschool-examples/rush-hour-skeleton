module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    post '/sources' do
      c = Client.create(name: params["identifier"], root_url: params["rootUrl"])
    end

    not_found do
      erb :error
    end
  end
end
