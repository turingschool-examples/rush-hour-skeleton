require_relative "../models/response.rb"
require_relative "../models/processor.rb"
require 'pry'

module RushHour
  class Server < Sinatra::Base
    include Response, Processor

    not_found do
      @sources = Client.all
      erb :error
    end

    get "/" do
      @sources = Client.all
      erb :dashboard
    end
    get "/sources" do
      @sources = Client.all
      erb :sources
    end

    get "/sources/:identifier" do |identifier|
      @sources = Client.all
      @client = get_client_stats(identifier)
      @events = get_client_events(@client)
      @identifier = identifier
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
      @sources = Client.all
      @url = get_url_stats("/"+relativepath)
      if Url.find_by(path: "/#{relativepath}").nil?
        @message = "Path #{relativepath} does not exist!"
        erb :error
      else
        erb :client_url_info
      end
    end

    get "/sources/:IDENTIFIER/events/:EVENTNAME" do |identifier, eventname|
      @sources = Client.all
      @eventname = eventname
      @client = Client.find_by(identifier: identifier)
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
  end
end
