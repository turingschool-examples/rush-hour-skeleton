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
      erb :dashboard 
    end
    get "/sources" do
      @sources = Client.all
      erb :sources
    end

    get "/sources/:identifier" do |identifier|
      #possibly try to refactor to
      @client = Processor.get_client_stats(identifier)
      @id = identifier
      if Client.find_by(identifier: identifier).nil?
        erb :error_identifier
      elsif Client.find_by(identifier: identifier).payload.empty?
        erb :error_payload
      else
        erb :show
      end
    end

    get "/sources/:IDENTIFIER/urls/:RELATIVEPATH" do |identifier, relativepath|
      @url = Processor.get_url_stats("/"+relativepath)
      # require "pry"; binding.pry
      # @path = Processor.parse_url(identifier+"/"+relativepath)
      @identifier = identifier
      if Url.find_by(path: "/"+relativepath).nil?
        erb :error_path
      else
        erb :client_url_info
      end
    end

    get "/sources/:IDENTIFIER/events/:EVENTNAME" do |identifier, eventname|
      @eventname = eventname
      @client = Client.find_by(identifier: identifier)
      @data = Processor.get_event_stats(@client, eventname)
      # Processor.test_parse_date(@data)
      @total = @data.values.reduce(:+)
      if Payload.find_by(event: Event.find_by(event_name: eventname)).nil?
        erb :error_event
      else
        erb :event_name
      end

    end

    post "/sources" do
      # 1. Get hash of identifier and root url
      # 2. Create new client (without saving) with id and root url
      # 3. Return messages
      # 4. Set messages to http response
      data = clean_data(params)
      response = process_client(Client.new(data), params[:identifier])
      status response[:status]
      body response[:body]
    end

    post "/sources/:IDENTIFIER/data" do |identifier|
      response = Response.process_data(params, identifier)
      status response[:status]
      body response[:body]
    end

  end
end
