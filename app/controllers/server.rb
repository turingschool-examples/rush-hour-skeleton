module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    not_found do
      erb :error
    end

    post '/sources' do
      result = ClientCreator.new(params)
      status result.status
      result.body
    end
  end
end
