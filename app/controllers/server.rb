module RushHour
  class Server < Sinatra::Base
    not_found do
      erb :error
    end

    #post '/path_for_payload_in_JSON_format'
    #this is where we'd call in the parser and create_payload method
  end
end
