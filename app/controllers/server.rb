require 'byebug'


module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
      #this will show a welcome page and link to the
    end

    not_found do
      erb :error
    end

    post '/sources' do
      parsed_source = IdentifierParser.validate(params)
      status parsed_source.status
      body parsed_source.body
    end

    post '/sources/:identifier/data' do |identifier|
      json_parsed = JSON.parse(params['payload'])
      parsed_payload = PayloadParser.validate(json_parsed, identifier)
      status parsed_payload.status
      body parsed_payload.body
    end

    get '/sources/:identifier' do |identifier|
     # Sources.order(url: :desc)
     byebug
      @source = Source.find_by(identifier: identifier)
      @urls = @source.urls
      erb :show
    end
      # client is accessing the handle above
      # server is returning a request body in the form of a string
      # take in the url handler, parse it, check to see if anything in the title matches insidethe identifier db
      # if there's a match then
      # create
      #message, status_code = PayloadParser.new.valid?
      #payload_data = parse(params[:payload])
  end

end
