require_relative "../models/response.rb"

module RushHour

  class Server < Sinatra::Base
    include Response
    not_found do
      erb :error
    end

    get "/sources" do
      erb :sources
    end

    post "/sources" do
      request_parser(params)
      status process_client[:status]
      body process_client[:body]
    end
  end
end
