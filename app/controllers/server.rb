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

    post '/sources/:id/data' do |id|
      parser = PayloadParser.new(params)
      status parser.status
      body parser.body
    end

  end
end
