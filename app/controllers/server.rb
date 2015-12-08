module TrafficSpy
  class Server < Sinatra::Base

    get '/' do
      erb :index
    end

    post '/sources' do
      app_reg  = AppRegistrar.create(:identifier => params[:identifier])
      {identifier: params[:identifier]}
    end

    not_found do
      erb :error
    end
  end
end
