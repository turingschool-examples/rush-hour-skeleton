require 'json'
require 'digest'
require './app/models/json_parser.rb'

module TrafficSpy
  class Server < Sinatra::Base
    set :show_exceptions, false

    get '/' do
      erb :index
    end

    post '/sources' do
      source = Source.new(:root_url => params[:rootUrl], :identifier => params[:identifier])
      if source.save
        {:identifier => source.identifier}.to_json
      else
        status StatusMessages.status_message(source)

        body source.errors.full_messages.join(", ")
      end
    end

    post '/sources/:identifier/data' do |identifier|
      source = Source.find_by(:identifier => params["identifier"])
      if params["payload"].nil?
        status StatusMessages.blank_payload
        body "payload can't be blank"
      elsif source
        data = JsonParser.parse_json(params["payload"], source)
        if data.save
          body "Created Successfully"
        else
          status StatusMessages.status_message(data)
          body data.errors.full_messages.join(", ")
        end
      else
        status StatusMessages.blank_identifier
        body "Identifier does not exist"
      end
    end

    get '/sources/:identifier' do |identifier|
      counts = Hash.new 0
      TrafficSpy::Payload.find_each do |x|
          counts[x.url_id] += 1
        end
      @max_min_hash = counts.map { |k, v| {TrafficSpy::URL.find(url_id = k).url => v}}

      # TrafficSpy::Payload.max_by()
      erb :source_page
    end

    not_found do
      erb :error
    end
  end
end
