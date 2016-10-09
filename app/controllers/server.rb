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
  end

end
