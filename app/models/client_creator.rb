class ClientCreator
  attr_reader :status, :body
  # attr_reader :client

  def initialize(params)
    create_status_and_body(params)
    # @client = Client.new(identifier: params[:identifier],
                  # rootUrl: params[:rootUrl])
  end

  def create_client(params)
    Client.new(identifier: params[:identifier],
                  rootUrl: params[:rootUrl])
  end

  def create_status_and_body(params)
    client = create_client(params)

    if Client.exists?(identifier: client.identifier)
      client_already_exists(client)
    elsif client.save
      client_created(client)
    else
      client_missing_params(client)
    end
  end

  def client_already_exists(client)
    @status = 403
    @body   = "Client with identifier: \"#{client.identifier}\" already exists!\n"
  end

  def client_created(client)
    @status = 200
    @body   = "{\"identifier\":\"#{client.identifier}\"}\n"
  end

  def client_missing_params(client)
    @status = 400
    @body   = "#{client.errors.full_messages.join(", ")}\n"
  end

end
