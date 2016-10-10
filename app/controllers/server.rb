require_relative "../models/response.rb"
require_relative "../models/processor.rb"
require 'pry'

module RushHour
  class Server < Sinatra::Base
    include Response, Processor

    not_found do
      erb :error
    end

    get "/sources" do
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
