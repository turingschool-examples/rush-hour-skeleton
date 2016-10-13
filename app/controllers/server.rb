require_relative "../models/response.rb"
require_relative "../models/processor.rb"
require 'pry'

module RushHour
  class Server < Sinatra::Base
    include Response, Processor

    not_found do
      erb :error
    end

    get "/" do
      erb :index
    end

    get "/sources/:identifier" do |identifier|
      @client = get_client_stats(identifier)
      @events = get_client_events(@client)

      if Client.find_by(identifier: identifier).nil?
        @message = "Identifier #{identifier} does not exist!"
        erb :error
      elsif Client.find_by(identifier: identifier).payload.empty?
        @message = "Your identifier #{identifier} does not have any assigned payloads!"
        erb :error
      else
        erb :show
      end
    end

    get "/sources/:IDENTIFIER/urls/:RELATIVEPATH" do |identifier, relativepath|
      @url = get_url_stats("/"+relativepath)
      @client = get_client_stats(identifier)
      @events = get_client_events(@client)

      if Url.find_by(path: "/#{relativepath}").nil?
        @message = "Path #{relativepath} does not exist!"
        erb :error
      else
        erb :show_url
      end
    end

    get "/sources/:IDENTIFIER/events/:EVENTNAME" do |identifier, eventname|
      @eventname = eventname
      @client = Client.find_by(identifier: identifier)
      @events = get_client_events(@client)
      @data = get_event_stats(@client, eventname)
      @total = @data.values.reduce(:+)

      if Payload.find_by(event: Event.find_by(event_name: eventname)).nil?
        @message = "Event #{eventname} does not exist!"
        erb :error
      else
        erb :event_name
      end

    end

    post "/sources" do
      data = clean_data(params)
      response = process_client(Client.new(data), params[:identifier])
      status response[:status]
      body response[:body]
    end

    post "/sources/:IDENTIFIER/data" do |identifier|
      response = process_data(params, identifier)
      status response[:status]
      body response[:body]
    end

    get "/redirect" do
      @identifier = params["search-id"]

      if Client.find_by(identifier: @identifier).nil?
        @message = "Identifier #{@identifier} does not exist!"
        erb :error
      else
        redirect "/sources/#{@identifier}"
      end
    end

    get "/sources" do
      @sources = Client.all
      erb :sources
    end

  end
end
