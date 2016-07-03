module RushHour
  class Server < Sinatra::Base
    not_found do
      erb :error
    end
  end
end
#
