module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    not_found do
      erb :error
    end

    post '/sources' do
      require "pry"; binding.pry
      user = User.new(params[:user])
      if user.save
        status 200
        body "Success - 200 OK"
      else
        status 400
        body task.errors.full_messages.join(", ")
      end
    end
  end
end
