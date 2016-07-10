module RushHour
  class Server < Sinatra::Base
    not_found do
      erb :error
    end

    post '/sources' do
      client = Client.new(identifier: params[:identifier], root_url: params[:rootUrl])
      if client.save
        status  200
        body  client.errors.full_messages.join(", ")
      elsif client.errors.full_messages.include?("Identifier has already been taken")
        status 403
        body  client.errors.full_messages.join(", ")
      else
        status  400
        body  client.errors.full_messages.join(", ")
      end
    end

    post '/sources/:identifier/data' do |identifier|
      payload = DataParser.new(params[:payload]).parse_payload(identifier)
      if payload.save
        status 200
        body "Payload received"
      elsif client.errors.full_messages.include?("Payload can't be blank")
        status 400
        body client.errors.full_messages.join(", ")
      elsif client.errors.full_messages.include?("Payload has already been received")
        status 403
        body client.errors.full_messages.join(", ")
      elsif client.errors.full_messages.include?("Application has already been registered")
        status 403
        body client.errors.full_messages.join(", ")
      else
        payload.errors.full_messages
        body "Something else must be wrong."
      end
    end


    # this is for the client test: ["Identifier can't be blank", "Root url can't be blank"]

    #{"identifier"=>"jumpstartlab", "rootUrl"=>"http://jumpstartlab.com"}


    # #http://jumpstartlab.com'  http://localhost:9393/sources
    # HTTP/1.1 200 OK
    # Content-Type: text/html;charset=utf-8
    # Content-Length: 24
    # X-Xss-Protection: 1; mode=block
    # X-Content-Type-Options: nosniff
    # X-Frame-Options: SAMEORIGIN
    # Server: WEBrick/1.3.1 (Ruby/2.3.0/2015-12-25)
    # Date: Sat, 09 Jul 2016 20:03:56 GMT
    # Connection: Keep-Alive
  end
end
