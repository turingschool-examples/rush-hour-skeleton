require 'json'

module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    post '/sources' do
      register_app = TrafficSpy::RegisterApplication.new(params)
      # application = TrafficSpy::Application.new({ identifier: params[:identifier], root_url: params[:rootUrl] })
      #
      # if application.save
      #   status 200
      #   body JSON.generate(params.select { |k, v| k == 'identifier' })
      # elsif application.errors.full_messages == ["Identifier has already been taken"]
      #   status 403
      #   body application.errors.full_messages
      # else
      #   status 400
      #   body application.errors.full_messages
      # end
    end

    not_found do
      erb :error
    end
  end
end
