module TrafficSpy
  class Server < Sinatra::Base

    get '/' do
      erb :index
    end

    not_found do
      erb :error
    end

    post '/sources' do
      source = Source.new(params)
      if Source.find_by(identifier: source.identifier)
        status 403
        "identifier already exists"
      elsif source.save
        status 200
        body JSON.generate({:identifier=>source.identifier})
      else
        status 400
        body source.errors.full_messages.join(", ")
      end
    end

    post '/sources/:identifier/data' do |identifier|
      #payload = PayloadParser.new(params[:payload], identifier)
      #payload.validate
      #status payload.result[:status]
      #body payload.result[:body]
      #
      source = Source.find_by(identifier: identifier)

      if source.blank?
        status 403
        body "application not registered"
      elsif params[:payload].blank?
        status 400
        body "missing payload"
      elsif Payload.find_by(digest: Digest::SHA1.hexdigest(params[:payload]))
        status 403
        body "already received request"
      else
        payload = source.payloads.create(
            digest: Digest::SHA1.hexdigest(params[:payload]),
            url: Url.where(address: JSON.parse(params[:payload])["url"]).first_or_create,
            requested_at: JSON.parse(params[:payload])["requestedAt"])
        status 200
      end
    end

  end
end
