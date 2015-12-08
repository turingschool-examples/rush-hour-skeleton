module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    post '/sources' do
      register_app = TrafficSpy::RegisterApplication.new(params)
      response_status, response_body = register_app.save

      status response_status
      body response_body
    end

    not_found do
      erb :error
    end
  end
end
