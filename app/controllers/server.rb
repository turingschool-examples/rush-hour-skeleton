module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    post '/sources' do
      Source.create
      body = "{\"identifier\": \"stanley\"}"
    end

    not_found do
      erb :error
    end
  end
end


# a  Fred comment.
