class RequestMaker
  attr_reader :params, :identifier

  def initialize(identifier, params)
    @params = params
    @identifier = identifier
  end

  def make
    client = Client.find_by(identifier: identifier)
    payload_data = Parser.new(params).payload_parser
    client.payload_requests.create(payload_data)
  end

end
