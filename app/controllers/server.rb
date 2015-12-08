module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    post '/sources' do
      client = Client.new(name: params["identifier"], root_url: params["rootUrl"])

      if Client.find_by(name: params["identifier"])
        status 403
        body "Name already taken." 
      elsif client.save
          body "Client created."
      else
        status 400
        body "Missing parameters."
      end
    end

    not_found do
      erb :error
    end
  end
end
