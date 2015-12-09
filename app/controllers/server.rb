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

    post '/sources/:id/data' do |id|
      if params[:payload].nil?
        status 400
        body "Payload can't be blank"
      elsif TrafficSpy::Application.find_by(identifier: id).nil?
        status 403
        body "Identifier not registered"
      else 
        status 200
      end 
    end

    not_found do
      erb :error
    end
  end
end
