module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    get '/sources' do
      erb :sources
    end

    post '/sources' do
      source = Source.new({identifier: params[:identifier], root_url: params[:rootUrl]})
      if source.save
        {identifier: source.identifier}.to_json
      else
        status 400
        body source.errors.full_messages.join(", ")
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
