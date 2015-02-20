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
      # source = Source.find_by(identifier: identifier)
      # return unless source
      # generator_result = PayloadGenerator.new(params[:payload])
      #find the source whos identifier is equal to :identifier
      #create payload bound to that source
        # require 'pry'; binding.pry#request has been previously sent and payload already exists
      if params[:payload].nil? || params[:payload].empty?
        status 400
        body "missing payload"
      elsif !Source.find_by(identifier: identifier)
        status 403
        body "not registered"
      elsif Payload.exists?
        #check all payloads for a matching id
        #if id is found, return error
        status 403
        body "duplicate request"
      else

        payload_params = JSON.parse(params[:payload]).symbolize_keys
        # payload = Payload.find_or_initialize_by({
        #   url: Url.find_or_create_by(address: payload_params[:url]),
        #
        #   })
        # if payload.new_record?
        #   # create it (payload.save)
        # else
        # end
        # url = Url.find_or_create(url: payload[:url_id])
        #assign each element of payload to its associated table/class

      end


      # source = Source.find_by(:identifier => identifier)
      # require 'pry'; binding.pry
      # payload = Payload.create(JSON.parse(params[:payload]))

    end


    not_found do
      erb :error
    end
  end
end
