# require_relative '../models/source'
require 'pry'
require 'byebug'

module TrafficSpy
  class Server < Sinatra::Base

    # register Sinatra::Partial
    # set :partial_template_engine, :erb
    #
    # helpers do
    #   def image_tag(url, alt)
    #     "<img src='#{url}' alt='#{alt}' />"
    #   end
    #
    #   def date_object_parser_thing
    #
    #   end
    # end

    get '/' do
      erb :index
    end

    post '/sources' do
      source = Source.new(rootUrl: params[:rootUrl], identifier: params[:identifier])
      if source.save
        {identifier: source.identifier}.to_json
      elsif source.errors.full_messages.include?("Identifier has already been taken")
        status 403
        "identifier already exists"
      else
        # source.errors.full_messages == ["Rooturl can't be blank"]
        status 400
        "missing a parameter ya doofus"
      end
    end

    post '/sources/:identifier/data' do
      payload_parser = PayloadParser.new
      payload = payload_parser.parse(params)

      if payload.has_key?("payload")
        raw_payload = payload_parser.parse(params)
        payload = payload_parser.change_names(raw_payload)
        payload_sha = ShaGenerator.create_sha(payload)
        payload[:sha] = payload_sha
        pi = Payload.create(payload)
          if pi.errors.full_messages.include?("Sha has already been taken")
            status 403
            "payload has already been created"
          else
            status 200
          end
      else
        status 400
        "missing payload ya ding dong"
      end
    end

    not_found do
      erb :error
      status 403
      body "source not created, missing parameters"
    end
  end
end

#
# post '/sources/:identifier/data' do
#   # require 'pry'; binding.pry
#   payload = TrafficSpy::Payload.new(request.params)
#   if payload.save
#     status 200
#   else
#     status 400
#   end
#
# end

# post '/sources/:identifier/data' do
#   require 'json'
#
#   json_params = params.to_json
#
#   data = JSON.parse(json_params)
#   payload = TrafficSpy::Payload.new(data)
#   if payload.save
#     status 200
#   else
#     status 400
#   end
#
# end
