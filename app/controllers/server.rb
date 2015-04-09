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
      parser = IdentifierParser.validate(params)
      status parser.status
      body parser.body
      #identifier.new shouldhappen in the parse

    end

    post '/sources/:identifier/data' do |identifier|
      url = JSON.parse(params["payload"])["url"]
      Payload.create(url: url)

      "Success"
      # client is accessing the handle above
      # server is returning a request body in the form of a string
      # take in the url handler, parse it, check to see if anything in the title matches insidethe identifier db
      # if there's a match then
      # create
      #message, status_code = PayloadParser.new.valid?
      #payload_data = parse(params[:payload])
    end
  end
end
