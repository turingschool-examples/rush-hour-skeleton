module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    not_found do
      erb :error
    end

    post '/sources' do
      identifier = Identifier.new(params[:identifier])
      if identifier.save
        status 200
        body "success"
      else
        status 400
        body identifier.errors.full_messages
      end
    end
  end
end
