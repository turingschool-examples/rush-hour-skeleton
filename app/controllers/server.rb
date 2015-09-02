module TrafficSpy
  class Server < Sinatra::Base

    get '/' do
      erb :index
    end

    post '/sources' do
      source_attributes = {}
      source_attributes[:root_url] = params[:rootUrl]
      source_attributes[:identifier] = params[:identifier]

      source = Source.new(source_attributes)
      valid_source = source.valid?
      error_message = source.errors.messages.values.flatten.first
      specific_error = source.errors.full_messages.first
      if valid_source
        source.save
        status "200 OK"
        return_value = {:identifier => source.identifier}.to_json
        body return_value
      elsif error_message == "can't be blank"
        status "400 Bad Request"
        body "Missing Parameters: #{specific_error}"
      elsif error_message == "has already been taken"
        status "403 Forbidden"
        body "Parameter Already Taken: #{specific_error}"
      end
    end

    not_found do
      erb :error
    end
  end
end
