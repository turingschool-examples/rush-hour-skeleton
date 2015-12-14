class RequestManager
  attr_reader :status, :response

  def initialize(params)
    parser = Parser.new(params)
    request = Request.new(request_hash: parser.request_hash)

    if params[:payload].nil?
      @status = 400
      @response =  "Missing payload."
    else params[:payload]
      if Application.exists?(identifier: params[:id])
        if request.valid?
          Url.create(path: parser.url)
          Event.create(name: parser.event)
          Request.create(parser.request_data)
          @status = 200
          @response = "Success."
        else
          @status = 400
          @response = "Duplicate entry."
        end
      else
        @status = 403
        @response = "Application not registered."   # parser
      end
    end
  end
end
