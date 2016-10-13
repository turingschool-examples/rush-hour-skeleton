require_relative '../models/client'
require_relative '../models/processor'
require 'pry'

module RushHour
  class Server < Sinatra::Base
    def not_found(error_type)
      @error_message = error_type
      erb :error
    end

    get "/" do
      erb :dashboard
    end
    
    get "/sample_sender" do
      erb :sample_sender
    end

    get "/sources" do
      status 200
      erb :sources
    end

    get "/sources/" do
      return (status 400) && not_found(page_not_found)
      erb :error
    end

    get "/login" do
      erb :login
    end

    get "/sources/:identifier" do |client_identifier|
      return not_found("Client does not exist.") if Client.find_by(identifier: client_identifier).nil?
      return not_found("No payloads for client.") if Client.find_by(identifier: client_identifier).payloads.empty?
      @client = Client.find_by(identifier: client_identifier)
      @events = @client.all_event_names
      erb :sources_user
    end

    post "/sources" do
      client_params = Hash.new
      client_params[:identifier] = params["identifier"]
      client_params[:root_url] = params["rootUrl"]
      return status 400 unless Client.new(client_params).valid?
      return status 403 if Client.pluck(:identifier).include?(client_params[:identifier])
      Client.create(client_params)
    end

    post "/sources/:identifier/data" do |identifier|
      return (status 400) && payload_missing unless params.keys.include?("payload")
      return (status 403) && client_doesnt_exist if Client.find_by(identifier: identifier).nil?
      return (status 403) && payload_invalid unless payload_valid?(params, identifier)
      Processor.parse(params[:payload], identifier)
    end

    get "/sources/:identifier/urls/:relative_path" do
      @url = Processor.rebuild(params[:identifier], params[:relative_path])
      @url_object = Url.find_by(url: @url)
      @client = Client.find_by(identifier: params[:identifier])
      return not_found("The entered path has not been requested by a user.") if @client.urls.find_by(url: @url).nil?
      erb :show_client_url
    end

    get "/sources/:identifier/events/:event_name" do
      @client = Client.find_by(identifier: params[:identifier])
      @event_name = params[:event_name]
      event = EventName.find_by(event_name: @event_name)
      return (status 404) && event_not_defined if event.nil?
      @hours = event.events_by_hour(@client)

      erb :show_client_events
    end

    delete '/sources/:identifier' do |client_id|
      id = Client.find_by(identifier: client_id).id
      Payload.where(client_id: id).delete_all
      Client.where(id: id).delete_all
      redirect '/'
    end

    def client_doesnt_exist
      p "Client doesn't exist."
    end

    def payload_missing
      p "This input is missing a payload. Please try again."
    end

    def payload_valid?(params, identifier)
      Processor.validate_payload(params[:payload], identifier)
    end

    def payload_invalid
      p "The payload is invalid, please try again."
    end

    def event_not_defined
      erb :event_not_defined_error
    end
    
    def page_not_found
      @error_message = "Please enter your user identifier before pressing access data."
    end

  end
end
