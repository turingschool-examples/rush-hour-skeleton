module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    post '/sources' do
      application = Application.new(params)

      if params[:identifier].nil?
        status 400
        "Missing identifier."
      elsif params[:rootUrl].nil?
        status 400
        "Missing rootUrl."
      elsif application.save
        status 200
        "Application created."
      else
        status 403
        "Identifier already exists."
      end
    end

    not_found do
      erb :error
    end
  end
end
