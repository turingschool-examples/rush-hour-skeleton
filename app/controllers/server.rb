module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    not_found do
      erb :error
    end

    post '/sources' do
      # binding.pry
      # user = User.create(identifier: params[:identifier], root_url: params[:rootUrl])
      user = User.create(identifier: params[:identifier], root_url: params[:rootUrl])
    end
  end
end
