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
    
    get "/sources/:identifier" do |client_identifier|
      @payloads = Payload.where(client_id: Client.find_by(identifier:         client_identifier).id)
      @client = Client.find_by(identifier: client_identifier)
      erb :sources_user
    end

    post "/sources" do
      client_params = Hash.new
      client_params[:identifier] = params["identifier"]
      client_params[:root_url] = params["rootUrl"]
      status 400 unless Client.new(params).valid?
      status 403 if Client.pluck(:identifier).include?(params[:identifier])
    end

    post "/sources/:identifier/data" do |identifier|
      return (status 400) && payload_missing unless params.keys.include?("payload")
      return (status 403) && client_doesnt_exist if Client.find_by(identifier: identifier).nil?
      return (status 403) && payload_invalid unless payload_valid?(params, identifier)
      Processor.parse(params[:payload], identifier)
    end

    def client_doesnt_exist
      p "Client doesn't exist."
    end

    def payload_missing
      p "the damn payload is missing, bro"
    end

    def payload_valid?(params, identifier)
      Processor.validate_payload(params[:payload], identifier)
    end

    def payload_invalid
      p "the damn payload was already received or is invalid, bro"
    end

  end
end
