module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    not_found do
      erb :error
    end

    post '/sources' do
    	User.create(params[:sources])
    	body 'success'
    end

  end
end
