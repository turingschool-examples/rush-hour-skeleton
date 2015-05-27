module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    get '/sources' do

    end

    post '/sources' do
      source = Source.new(params[:source])
      if source.save
        status 200
        body "Registration complete."
      else
        status 403
        body source.errors.full_messages
      end
      # params (identifier rooturl)
      # curl -i -d 'identifier=(thing)&rooturl=(thing)' http://ourapp:port/sources
    end

    not_found do
      erb :error
    end
  end
end
