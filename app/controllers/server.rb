require 'json'

module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    post '/sources' do
      # require 'pry'; binding.pry
      application = TrafficSpy::Application.new({ identifier: params[:identifier], root_url: params[:rootUrl] })
      # TrafficSpy::Application.create({ identifier: params[:identifier], root_url: params[:rootUrl] })
      if application.save 
        status 200
        body JSON.generate(params.select { |k, v| k == 'identifier' })
      elsif application.errors.full_messages == ["Identifier has already been taken"]
        status 403
        body application.errors.full_messages          
      else
        status 400
        body application.errors.full_messages
      end

    end

    post '/sources/:id/data' do |id|
      # binding.pry
      if params[:payload].nil?

        status 400
        body "Payload can't be blank"
      elsif TrafficSpy::Application.find_by(identifier: id).nil?
        status 403
        body "Identifier not registered"
      else 
        status 200
      end 
    end

    not_found do
      erb :error
    end
  end
end
