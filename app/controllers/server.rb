require_relative '../models/unique'
require 'useragent'

module RushHour
  class Server < Sinatra::Base
    include Unique

    not_found do
      erb :error
    end

    post '/sources/:identifier/data' do |identifier|
      parsed_payload = JSON.parse(params["payload"])
      #what's the status?
      #what's the body?
      #convert teh user agent into a hash we can send to table
      parsed_user_agent = parse_user_agent_info(parsed_payload["userAgent"])
      payload = PayloadRequest.new(
        url: Url.find_or_create_by(address: parsed_payload["url"]),
        requested_at: parsed_payload["requestedAt"],
        responded_in: parsed_payload["respondedIn"],
        referred_by: ReferredBy.find_or_create_by(name: parsed_payload["referredBy"]),
        request_type: RequestType.find_or_create_by(name: parsed_payload["requestType"]),
        parameters: parsed_payload["parameters"],
        event: Event.find_or_create_by(name: parsed_payload["eventName"]),
        user_agent_info: UserAgentInfo.find_or_create_by(parsed_user_agent),
        screen_size: ScreenSize.find_or_create_by(resolution_width: parsed_payload["resolutionWidth"], resolution_height: parsed_payload["resolutionHeight"]),
        ip: Ip.find_or_create_by(address: parsed_payload["ip"]),
        sha: create_sha(parsed_payload)
      )


      if payload_sha_exists?(payload)
        response.status = 403
        response.body = "Payload already exists"
      else
        if payload.save
          response.status = 200
          response.body = "Payload created"
        else
          response.status = 403
          payload.errors.full_messages.join(", ")
        end
      end

    end



    post '/sources' do
      client_sha = create_sha(params)
      client = Client.new(identifier: params["identifier"], root_url: params["rootUrl"], sha: client_sha)
      if client_sha_exists?(client)
        response.status = 403
        response.body = "Client already exists"
      else
        if client.save
          response.status = 200
          response.body = "Client created"
        else
          response.status = 400
          response.body = client.errors.full_messages.join(", ")
        end
      end
    end

    def parse_user_agent_info(user_agent_info)
      user_agent_qualities = {}
      user_agent = UserAgent.parse(user_agent_info)
      user_agent_qualities[:browser] = user_agent.browser
      user_agent_qualities[:platform] = user_agent.platform
      user_agent_qualities[:version] = "Windows 8.1"
      user_agent_qualities[:os] = user_agent.os
      user_agent_qualities
    end
  end
end
