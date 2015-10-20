module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    not_found do
      erb :error
    end

    post '/sources' do
      # check if identifier Exists (via params)
      
        #if not
          # post data to database
          # make new instance of Source
          # return message
    end
  end
end
