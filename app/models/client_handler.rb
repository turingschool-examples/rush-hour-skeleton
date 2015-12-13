class ClientHandler

  attr_reader :client, :body, :status

  def initialize(given_client)
    @client = given_client
    @body = generate_body
    @status = generate_status
  end

  def generate_body
    return "Name already taken." if Client.find_by(name: client.name)
    return "Client created." if client.save
    return "Missing parameters."
  end

  def generate_status
    return 403 if body == "Name already taken."
    return 400 if body == "Missing parameters."
    return 200
  end

end
