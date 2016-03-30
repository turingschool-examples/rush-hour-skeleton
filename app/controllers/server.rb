module RushHour
  class Server < Sinatra::Base
    not_found do
      erb :error
    end

    post '/sources' do
      client = ClientCreator.new(params)
      status client.status
      body client.body
    end

  end
end
