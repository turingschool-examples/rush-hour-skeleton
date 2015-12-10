module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    post '/sources' do
      registrator = Registrator.new(params)
      status registrator.status
      body   registrator.response
    end

    post '/sources/:id/data' do |id|
      registrator = RequestManager.new(params)
      status registrator.status
      body   registrator.response
    end

    not_found do
      erb :error
    end
  end
end
