require_relative '../models/data_parser' # <= this doesn't work yet
require "pry"

module RushHour
  class Server < Sinatra::Base

    post '/sources' do
      client_data = DataParser.new(params)
      parsed_client = client_data.formatted_client
      client = Client.new(parsed_client)
      if Client.exists?(identifier: params["identifier"])
        status 403
        body "Identifier Already Exists"
      elsif client.save
        "{'identifier':'#{params['identifier']}'}"
        status 200
        body "Success!"
      else
        status 400
        body "Missing Parameters"
      end
    end

    post '/sources/:identifier/data' do
      client = Client.find_by(identifier: params["identifier"])
      if client
        if params["payload"].nil?
          status 400
          body "Missing payload"
        elsif PayloadRequest.exists?(url_id: payload)
          status 403
          body "Already received"
        else
          payload_data = DataParser.new(params)
          payload_data.assign_foreign_keys
          status 200
          body "Success"
        end
      else
        status 403
        body "Application not registered"
      end
    end

      # parsed_payload = payload_data.assign_foreign_keys
      # saved_payload = PayloadRequest.find_by(client_id: client.id)

      #   if payload_data.assign_foreign_keys is successful,
      #     200 success
      #   elsif payload_data.assign_foreign_key is unsuccessful
      #       if unsuccessful because params["payload"] = nil
      #         400 bad request missing payload
      #       elsif unsuccessful because Payload.exists?(pass in all the things)
      #         403 already received
      # else
      #     403 forbidden application not registered
      # end
      #
      #   perform_payload_uniqueness_check (is this something we are already doing in assign_foreign_keys? I think so)
      #   if check is passed save payload
      #   else return error
      # p params

    not_found do
      erb :error
    end
  end
end
