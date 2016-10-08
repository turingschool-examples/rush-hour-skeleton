module Response
  extend self

  def request_parser(params)
    @identifier = params[:identifier]
    @root_url = params[:rootUrl]
  end

  def process_client
    if @identifier.nil? || @root_url.nil?
      {status: 400, body: "Missing Parameters\n"}
    end
  end
end
