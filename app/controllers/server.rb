module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    not_found do
      erb :error
    end

    post '/sources' do
      client = Client.new({identifier: params[:identifier], root_url: params[:rootUrl]})
      if client.save
        "{'identifier':'#{client.identifier}'}"
      else
        status 403
        "missing identifier or rootUrl"
      end
    end
  end
end
