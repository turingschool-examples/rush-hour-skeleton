require 'pry'
module RushHour
  class Server < Sinatra::Base
    post '/sources' do
      parsed_client_attributes = IdentifierParser.new(params).parse

      client = Client.new(parsed_client_attributes)
      if client.save
        status 200
        body "{\"identifier\": \"#{client.identifier}\"}"
      elsif client.errors.full_messages.include?("Root url has already been taken") or client.errors.full_messages.include?("Identifier has already been taken")
        status 403
        body client.errors.full_messages.join(',')
      else
        status 400
        body client.errors.full_messages.join(', ')
      end
    end

    post '/sources/:identifier/data' do |identifier|
      unless Client.find_by(identifier: identifier)
        status 403
        body "403 Forbidden - Application Not Registered"
      else
        parsed_payload_attributes = PayloadParser.new(params).parse
        payload = PayloadPopulator.populate(parsed_payload_attributes, identifier)

        if PayloadRequest.find_by(requested_at: payload.requested_at, responded_in: payload.responded_in, resolution_id: payload.resolution_id, system_information_id: payload.system_information_id, referral_id: payload.referral_id, ip_id: payload.ip_id, request_type_id: payload.request_type_id, url_id: payload.url_id, client_id: payload.client_id)
          status 403
          body "403 Forbidden - Already Received Request"
        elsif payload.save
          status 200
          body "200 OK"
        else
          status 400
          body "400 Bad Request: " + payload.errors.full_messages.join('. ')
        end
      end
    end

    get '/sources/:identifier' do |identifier|
      @client = Client.find_by(identifier: identifier)
      if @client.nil?
        status 403
        body "403 Forbidden - Identifier does not exist"
      else
        @payloads = @client.payload_requests
        if @payloads.empty?
          status 403
          body "403 Forbidden - No Payload data for this source"
        else
          status 200
          erb :'client/show'
        end
      end
    end

    get '/sources/:identifier/urls/:relative_path' do |identifier, relative_path|
      @client = Client.find_by(identifier: identifier)
      if @client.nil?
        status 403
        body "403 Forbidden - Identifier does not exist! Ya Dun Goofed! YA DING DONG!"
      else
        @url = Url.find_by(web_address: "#{@client.root_url}/#{relative_path}")
        if @url.nil?
          status 403
          body "403 Forbidden - No Payload data for this source"
        else
          status 200
          erb :'urls/show'
        end
      end
    end

    get '/sources' do
      @clients = Client.all
      erb :sources
    end

    get '/about' do
      erb :about
    end

    not_found do
      erb :error
    end

    helpers do
      def home_link
        "<a href='/sources'>Home</a>"
      end

      def sources_identifier_link
        "<a href='/sources/#{@client.identifier}'>Link to Source Info</a>"
      end

      def identifier_link(identifier)
        "<a href='/sources/#{identifier}'>#{identifier.capitalize} statistics</a>"
      end
    end
  end
end
