require 'pry'
module RushHour
  class Server < Sinatra::Base
    post '/sources' do
      p params
      parsed_client_attributes = IdentifierParser.new(params[:source]).parse
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

    not_found do
      erb :error
    end
  end
end
