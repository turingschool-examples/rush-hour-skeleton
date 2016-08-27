module RushHour

  class Server < Sinatra::Base
    not_found do
      erb :error
    end

    post '/sources' do
      client = ClientParser.create(params)
      if client.save
        status 200
        body "{\"identifier\":\"#{params[:identifier]}\"}"
      elsif client.errors.full_messages == ["Identifier has already been taken"]
        status 403
        body client.errors.full_messages.join(", ")
      else
        status 400
        body client.errors.full_messages.join(", ")
      end
    end

    post '/sources/:identifier/data' do
      payload = PayloadParser.create(params)
      if payload.save
        status 200
        body "{\"identifier\":\"#{params[:identifier]}\"}"
      # elsif PayloadRequest.exists?( :requested_at => payload.requested_at )
      #   status 403
      #   body "Identifier has already been taken"
      else
        status 400
        binding.pry
        body "Parameters not complete"
      end
    end
  end

end
