require_relative '../models/client'

module RushHour
  class Server < Sinatra::Base
    not_found do
      erb :error
    end
  
    get "/" do
      erb :dashboard
    end
  
    get "/sources" do
      status 200
    end
    
    post "/sources" do
      client_params = Hash.new
      client_params[:identifier] = params["identifier"]
      client_params[:root_url] = params["rootUrl"]
      status 400 if Client.missing_parameters(client_params)
      status 403 if Client.identifier_exists(client_params)
      status 200 unless Client.missing_parameters(client_params) || Client.identifier_exists(client_params)
    end
        
  end
end
