require 'json'
module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    not_found do
      erb :error
    end

    post '/sources' do



      if params[:identifier] == nil || params[:url] == nil
        status 400
        body "Missing Parameters - 400 Bad Request"
      else
        status 200
        body "{'identifier' : '#{params[:identifier]}'}"
      end
    end

  end
end
