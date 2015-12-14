class RequestManager
  attr_reader :status, :response, :parser, :request, :params

  def initialize(params)
    @params  = params
    @parser  = Parser.new(params)
    @request = Request.new(request_hash: parser.request_hash)

    @status, @response = process_request
  end

  def process_request
    case
    when params[:payload].nil? then [400, "Missing payload."]
    when unregistered_app?     then [403,"Application not registered."]
    when request.invalid?      then [400, "Duplicate entry."]
    when request.valid?        then create_records && [200, "Success."]
    end
  end

  def unregistered_app?
    !Application.exists?(identifier: params[:id])
  end

  def create_records
    Url.create(path: parser.url)
    Event.create(name: parser.event)
    Request.create(parser.request_data)
  end
end
