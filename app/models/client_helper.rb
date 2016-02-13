module ClientHelper
  
  def self.parse_client_params(params)
    client = Client.new(identifier: params[:identifier],
                        root_url:   params[:rootUrl])

    if client.save
      ApplicationHelper.status_message(200, { identifier: client.identifier }.to_json)
    elsif client.errors.full_messages.first == "Identifier has already been taken"
      ApplicationHelper.status_message(403, "403 Forbidden - Identifier already exists")
    else
      ApplicationHelper.status_message(400, "400 Bad Request - #{client.errors.full_messages.join(", ")}")
    end
  end

  def self.find_client(identifier)
    Client.find_by(identifier: identifier)
  end
end
