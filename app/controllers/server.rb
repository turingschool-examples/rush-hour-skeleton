require 'digest'

module TrafficSpy
  class Server < Sinatra::Base

    get '/' do
      erb :index
    end

    post "/sources" do
     source_params = {}
     source_params[:root_url]    = params[:rootUrl]
     source_params[:identifier]  = params[:identifier]

     source = Source.new(source_params)

      if source.save
        body "{identifier: #{params[:identifier]}}"
      else
        message = source.errors.messages.to_a.flatten
        registrator = SourceRegistrator.new(message)
        status registrator.error_status
        body registrator.error_message
      end
    end

    post "/sources/:identifier/data" do |identifier|
      payload_params = params.to_json
      payload_params = JSON.parse(payload_params)

      source = Source.find_by_identifier(identifier)
      validator = PayloadValidator.new(payload_params, source)

      status validator.error[0]
      body validator.error[1]
    end

    get '/sources/:identifier' do |identifier|
      source = Source.find_by_identifier(identifier)
      @payloads = Payload.where({:source_id => source.id})
      erb :show
    end

    not_found do
      erb :error
    end
  end
end
