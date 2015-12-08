module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    post '/sources' do

      application = Application.new(params[:application])
      "test"
binding.pry
      if params[:application][:identifier].nil?
        status 400
        "Missing identifier."
      elsif params[:application][:root_url].nil?
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
