module TrafficSpy
  class Server < Sinatra::Base

    get '/' do
      erb :index
    end

    post '/sources' do
      source = Source.new(params)
      if source.save
        status 200
        body source.simplified_json
      else
        if source.error_response.include? "taken"
          status 403
          body source.error_response
        else
          status 400
          body source.error_response
        end
      end
    end

    post '/sources/:identifier/data' do |identifier|
      #find the source whos identifier is equal to :identifier
      #create payload bound to that source

      source = Source.find_by(:identifier => identifier)
      payload = Payload.create(JSON.parse(params[:payload]))
      # require 'pry'; binding.pry
      if payload.valid?
        source.payloads << payload
        status 200
        body payload.simplified_json
      else
        status 400
        body payload.error_response
      end
    end

    not_found do
      erb :error
    end
  end
end
