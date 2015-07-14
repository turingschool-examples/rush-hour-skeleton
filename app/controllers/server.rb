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
      reg = Registration.create(params)

      if params[:identifier] == nil || params[:url] == nil
        status 400
        body "Missing Parameters - 400 Bad Request"

      else
        if reg.save
        status 200
        body "{'identifier' : '#{params[:identifier]}'}"
      else
        status 403
        body "Identifier Already Exists - 403 Forbidden"
      end

      end
    end

  end
end
