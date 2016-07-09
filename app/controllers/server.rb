module RushHour
  class Server < Sinatra::Base

    not_found do
      erb :error
    end

    post '/sources' do
      cv = ClientChecker.new(params).res
      status, body = cv
    end

    post "/sources/:identifier/data" do |identifier|
      RequestMaker.new(identifier, params).make
    end

    get "/sources/:identifier" do |identifier|
      @identifier = (Client.where(identifier: identifier).take)
      @avg_response_time = @identifier.average_response_time
      @max_response_time = @identifier.maximum_response_time
      @min_response_time = @identifier.minimum_response_time

      erb :client_show
    end

  end
end
