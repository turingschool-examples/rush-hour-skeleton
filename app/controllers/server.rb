module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    post '/sources' do
      source = Source.new(params)
      if source.save
        status 200
        body source.simplified_json
      else
        if source.error_response.include? "taken"
          status 403
          body source.error_response
        else
          status 400
          body source.error_response
        end
      end
    end

    not_found do
      erb :error
    end
  end
end
