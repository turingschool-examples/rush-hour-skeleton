module RushHour
  class Server < Sinatra::Base
    not_found do
      erb :error
    end
    
    # Write the rest of your controller code here!
  end
end
