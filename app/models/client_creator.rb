class ClientCreator
  attr_reader :status,
              :body,
              :client

  def initialize(params)
    @client = Client.new(identifier: params[:identifier],
                         root_url:    params[:rootUrl])
    create_status_and_body(params)
  end

  def create_status_and_body(params)
    if Client.exists?(identifier: client.identifier)
      client_already_exists
    elsif client.save
      client_created
    else
      client_missing_params
    end
  end

  # try hash refactoring

  def client_already_exists
    @status = 403
    @body   = "Client with identifier: \"#{client.identifier}\" already exists!\n"
  end

  def client_created
    @status = 200
    @body   = "{\"identifier\":\"#{client.identifier}\"}\n"
  end

  def client_missing_params
    @status = 400
    @body   = "#{client.errors.full_messages.join(", ")}\n"
  end

end
