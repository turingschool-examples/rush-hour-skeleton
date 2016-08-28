require_relative '../models/data_parser'
require_relative '../models/sub_table_checker'
require "pry"

module RushHour
  class Server < Sinatra::Base
    include SubTableChecker

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
      raw_payload = DataParser.new(params)
      formatted_payload = raw_payload.formatted_payload
      if client
        payload = PayloadRequest.find_by(url_id: check_url_exists(formatted_payload),
        referred_by_id: check_referred_by_exists(formatted_payload),
        request_type_id: check_request_type_exists(formatted_payload),
        u_agent_id: check_u_agent_exists(formatted_payload),
        resolution_id: check_resolution_exists(formatted_payload),
        ip_id: check_ip_exists(formatted_payload)
                                        )
        if payload
          status 403
          body "Already received"
        else
          new_payload = PayloadRequest.new(url_id: check_url_exists(formatted_payload),
          requested_at: formatted_payload["requested_at"],
          responded_in: formatted_payload["responded_in"],
          referred_by_id: check_referred_by_exists(formatted_payload),
          request_type_id: check_request_type_exists(formatted_payload),
          u_agent_id: check_u_agent_exists(formatted_payload),
          resolution_id: check_resolution_exists(formatted_payload),
          ip_id: check_ip_exists(formatted_payload)
                                          )
          if new_payload.save
            status 200
            body "Success"
          else
            status 400
            body "Missing payload data"
          end
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
