module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    post "/sources" do
      user_params = {}
      user_params[:root_url]    = params[:rootUrl]
      user_params[:identifier]  = params[:identifier]

      user = User.new(user_params)

      if user.save
        body "{identifier: #{params[:identifier]}}"
      end
    end

    not_found do
      erb :error
    end
  end
end
