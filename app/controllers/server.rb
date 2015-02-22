require 'useragent'

module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    post '/sources' do
      if Source.new(params).valid?
        source = Source.create(params)
        "{\"identifier\": \"#{source.identifier}\"}"
      elsif params.length != 2
        status 400
        body = "Missing Parameters"
      else
        status 403
        body = "Identifier Already Exists"
    end
    end

    post '/sources/:identifier/data' do |identifier|
      # payload_parser = PayloadParser.evaluate(params[:payload], identifier)
      # status payload_parser.status
      # body   payload_parser.body



      if Payload.find_by(raw_data: params["payload"])
        status 403
        body "payload already exists"



      elsif source = Source.find_by(identifier: identifier)



        payload_params = JSON.parse(params[:payload]).symbolize_keys
        # payload_data = PayloadData.call(payload_params)


        #params_length_checker
        if payload_params.size != 11
          status 400
          return body "incorrect amount of payload parameters"
        end


        user_agent = UserAgent.parse(payload_params[:userAgent])
          source.payloads.create({
          raw_data: params[:payload],
          url: Url.find_or_create_by(address: payload_params[:url]),
          requested_at: payload_params[:requestedAt],
          responded_in: payload_params[:respondedIn],
          referred_by: ReferredBy.find_or_create_by(name: payload_params[:referredBy]),
          request_type: RequestType.find_or_create_by(verb: payload_params[:requestType]),
          event: Event.find_or_create_by(name: payload_params[:eventName]),
          browser: Browser.find_or_create_by(name: user_agent.browser),
          os: Os.find_or_create_by(name: user_agent.platform),
          resolution: Resolution.find_or_create_by(width: payload_params[:resolutionWidth], height: payload_params[:resolutionHeight]),
          ip_address: IpAddress.find_or_create_by(address: payload_params[:ip])
          })
          body "successful"
      else
        status 403
        body "source is not registered"
        # status and message that source isn't registered
      end
    end

    not_found do
      erb :error
    end
  end
end


# a  Fred comment.
