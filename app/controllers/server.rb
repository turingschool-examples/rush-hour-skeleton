require_relative '../models/data_parser'
require_relative '../models/sub_table_checker'
require "pry"
require "useragent"

module RushHour
  class Server < Sinatra::Base
    include SubTableChecker
    #
    # get '/' do
    #   erb :
    # end

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
      # binding.pry
      if !raw_payload.raw_data.keys.include?("payload")
        status 400
        body "Missing payload"
      else
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
            # else
              # status 400
              # body "Missing payload data"
            end
          end
        else
          status 403
          body "Application not registered"
        end
      end
    end

    get '/sources/:identifier' do
      client = Client.find_by(identifier: params["identifier"])
      payloads = PayloadRequest.where(client_id: client.id) unless client.nil?
      if client.nil?
        @message = "#{params["identifier"]} does not exist"
        erb :'client/error'
      elsif payloads.empty?
        @message = "No payload data has been received for #{params["identifier"]}"
        erb :'client/error'
      else
        # @average_response_time = payloads.average_response_time
        erb :'client/dashboard', locals: {payloads: payloads}
      end
    end

    not_found do
      erb :error
    end
  end
end
