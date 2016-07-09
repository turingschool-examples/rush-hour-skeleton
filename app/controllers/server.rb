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
  end
end
