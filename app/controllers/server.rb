require 'byebug'

module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    not_found do
      erb :error
    end

    post '/sources' do
      identifier = Identifier.new(params[:identifier])
        # if identifier.title =
        #   status 403
        #   body "Duplicate Dummy!"
        if identifier.save
          status 200
          body "success"
        elsif identifier.title.nil?
          status 400
          body identifier.errors.full_messages
        elsif identifier.root_url.nil?
          status 400
          body identifier.errors.full_messages
        else
          status 403
          body identifier.errors.full_messages
        end
    end

  #  post '/sources/:title/data' do

      # client is accessing the handle above
      # server is returning a request body in the form of a string
      # take in the url handler, parse it, check to see if anything in the title matches insidethe identifier db
      # if there's a match then
      # create
      #message, status_code = PayloadParser.new.valid?
      #payload_data = parse(params[:payload])
    #end
  end
end
