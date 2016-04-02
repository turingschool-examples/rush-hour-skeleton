class ClientCreator
  attr_reader :status,
              :body,
              :client

  def initialize(params)
    @client = Client.new(identifier: params[:identifier],
                         root_url:   params[:rootUrl])
  end

  def create_client
    return already_exists if Client.exists?(identifier: client.identifier)
    return client_created if client.save
    parameters_missing
  end

  def already_exists
    @status = 403
    @body   = "Client with identifier: \"#{client.identifier}\" already exists!"
  end

  def client_created
    @status = 200
    @body   = "{\"identifier\":\"#{client.identifier}\"}"
  end

  def parameters_missing
    @status = 400
    @body   = "#{client.errors.full_messages.join(", ")}"
  end
end
