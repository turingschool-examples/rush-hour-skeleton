module RushHour
  class Server < Sinatra::Base
    post '/sources' do
      status, body = ClientParser.new.parse_client(params)
    end

    post '/sources/:IDENTIFIER/data' do
      status, body = PayloadParser.new.parse_payload(params)
    end

    not_found do
      erb :error
    end
  end
end
