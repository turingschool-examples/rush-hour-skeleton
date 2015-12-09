module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      haml :index
    end

    post '/sources' do
      response_status, response_body =  TrafficSpy::RegisterApplication.new(params).save

      status response_status
      body response_body
    end

    post '/sources/:id/data' do |id|
      response_status, response_body = TrafficSpy::ProcessPayload.new(params[:payload], id).process

      status response_status
      body response_body
    end

    get '/sources/:id' do |id|
      @app = TrafficSpy::Application.find_by(identifier: id)
      haml :url_statistics
    end

    not_found do
      haml :error
    end
  end
end
