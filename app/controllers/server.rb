module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    get '/sources' do
      erb :sources
    end

    post '/sources' do
      user = User.new(params[:user])

      if user.save
        "User Saved!"
      else
        status 400
        body user.errors.full_messages.join(", ")
      end
    end

    get '/identifier' do
      erb :identifier
    end

    not_found do
      erb :error
    end
  end
end
