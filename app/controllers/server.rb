module RushHour
  class Server < Sinatra::Base


    not_found do
      erb :error
    end

    post '/sources' do
      # require 'pry'; binding.pry
      cv = ClientChecker.new(params).res
      status, body = cv
    end

    post '/sources/' do

    end

  end
end
