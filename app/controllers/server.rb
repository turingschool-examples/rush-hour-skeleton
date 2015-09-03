require 'digest'

module TrafficSpy
  class Server < Sinatra::Base

    get '/' do
      erb :index
    end

    post "/sources" do
      user_params = {}
      user_params[:root_url]    = params[:rootUrl]
      user_params[:identifier]  = params[:identifier]

      user = User.new(user_params)

      if user.save
        body "{identifier: #{params[:identifier]}}"
      else
        message = user.errors.messages.to_a.flatten
        registrator = UserRegistrator.new(message)
        status registrator.error_status
        body registrator.error_message
      end
    end

    post "/sources/:identifier/data" do |identifier|
      payload_params = params.to_json
      payload_params = JSON.parse(payload_params)

      if payload_params['payload'].nil?
        status 400
        body 'Bad Request - Needs a payload'
      else
        user = User.find_by_identifier(identifier)
        if user.nil?
          status 403
          body 'Forbidden - Must have registered identifier'
        else
          sha = Digest::SHA256.hexdigest(params.to_s)
          generated_sha = Sha.new(sha: sha)
          if generated_sha.save
            status 200
          else
            status 403
            body 'Forbidden - Must be unique payload'
          end
        end
      end
    end

    not_found do
      erb :error
    end
  end
end
