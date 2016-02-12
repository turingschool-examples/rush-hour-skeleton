require 'json'

module RushHour
  class Server < Sinatra::Base
    post '/sources' do
      status, body = DataParser.new.parse_client(params)
    end

    not_found do
      erb :error
    end
  end
end
