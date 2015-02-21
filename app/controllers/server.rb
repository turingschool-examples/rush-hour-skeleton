require 'pry'
module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    post '/sources' do
      if Source.new(params).valid?
        source = Source.create(params)
        "{\"identifier\": \"#{source.identifier}\"}"
      elsif params.length != 2
        status 400
        body = "Missing Parameters"
      else
        status 403
        body = "Identifier Already Exists"
      end
    end

    post '/sources/:identifier/data' do |identifier|
      # payload_parser = PayloadParser.evaluate(params[:payload], identifier)
      # status payload_parser.status
      # body   payload_parser.body


      if Payload.find_by(raw_data: params[:payload])
      # if Payload.find_by(digest: Digest::SHA2.digest(params[:payload]))
        # return correct status and body saying that payload already exists
      elsif source = Source.find_by(identifier: identifier)
        payload_params = JSON.parse(params[:payload]).symbolize_keys
        # payload_data = PayloadData.call(payload_params)

        # binding.pry
        source.payloads.create({
          url: Url.find_or_create_by(address: payload_params[:url]),
          # url: payload_data.url,
          # digest: Digest::SHA2.digest(params[:payload])
          })
      else
        # status and message that source isn't registered
      end
    end


    not_found do
      erb :error
    end
  end
end


# a  Fred comment.
