module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    post '/sources' do
      source = Source.create(params)
      "{\"identifier\": \"#{source.identifier}\"}"

    end

    not_found do
      erb :error
    end
  end
end


# a  Fred comment.
