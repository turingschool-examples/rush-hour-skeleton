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

    post "/sources/:identifier/data" do |identifier|
      client = Client.find_by(:identifier).id
      #parse the params for the PR
      client.payload_requests.create(parsed_data) #if this doesn't work, move client id to parser
    end

  end
end
