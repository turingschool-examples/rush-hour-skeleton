module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    not_found do
      erb :error
    end

    get '/sources/:id' do |id|
      if @user = TrafficSpy::User.find_by(identifier: id)
        if @user.payloads.count == 0
          erb :no_payload_data, locals: {id: id}
        else
          erb :application_statistics
        end
      else
        erb :identifier_does_not_exist, locals: {id: id}
      end
    end


    post '/sources' do
      TrafficSpy::RegistrationParser.new(params).parsing_validating
    end

    post '/sources/:id/data'  do |id|
      TrafficSpy::PayloadParser.new(params).payload_response
    end
  end
end
