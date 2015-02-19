module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    post '/sources' do
      if Source.new(params).valid?
        source = Source.create(params)
        "{\"identifier\": \"#{source.identifier}\"}"
      elsif params.length != 2
        status 400
        body = "Missing Parameters"
      else
        status 403
        body = "Identifier Already Exists"
      end
    end

    post '/sources/:identifier/data' do |identifier|
      puts params

    end


    not_found do
      erb :error
    end
  end
end


# a  Fred comment.
