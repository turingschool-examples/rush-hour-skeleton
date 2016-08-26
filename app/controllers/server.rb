module RushHour
  class Server < Sinatra::Base
    not_found do
      erb :error
    end

    post '/sources' do
      status 200
      body "Hello, World!"
      # status: 404
    end

  end
end
