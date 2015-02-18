module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    post '/sources' do
      Identifier.create(params[:source])
    end

    not_found do
      erb :error
    end
  end
end
