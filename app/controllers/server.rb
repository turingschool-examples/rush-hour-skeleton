module RushHour
  class Server < Sinatra::Base
    not_found do
      erb :error
    end

    post '/sources' do
      client_creator = ClientCreator.new(params)
      client_creator.create_client
      status client_creator.status
      body client_creator.body
    end

    post '/sources/:id/data' do |id|
      parser = PayloadParser.new
      parser.send_request(params)
      status parser.status
      body parser.body
    end

    get '/sources/:identifier' do |identifier|
      gen_view = ViewGenerator.new(identifier)
      data     = gen_view.data
      view     = gen_view.view
      erb view
    end

  end
end
