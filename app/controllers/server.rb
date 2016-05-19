require_relative '../models/unique'

module RushHour
  class Server < Sinatra::Base
    include Unique

    not_found do
      erb :error
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
      require 'pry'; binding.pry
    end
  end
end
