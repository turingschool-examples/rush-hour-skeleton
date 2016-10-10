require_relative '../models/client'
require_relative '../models/processor'

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
      erb :sources
    end
    
    get "/login" do
      erb :login
    end

    post "/sources" do
      client_params = Hash.new
      client_params[:identifier] = params["identifier"]
      client_params[:root_url] = params["rootUrl"]
      status 400 unless Client.new(params).valid?
      status 403 if Client.pluck(:identifier).include?(params[:identifier])
    end

    post "/sources/:identifier/data" do |identifier|
      status 400 unless params.keys.include?("payload")
      Processor.parse(params[:payload], identifier)
    end

  end
end
