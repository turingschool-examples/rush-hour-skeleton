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
      status, body = Validator.validate(source)
    end

    get '/identifier' do
      erb :identifier
    end

    not_found do
      erb :error
    end
  end
end
