module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    post '/sources' do
      puts "code"
    end

    not_found do
      erb :error
    end
  end
end
