module Handler

  def self.post_to_sources(client, params)
    if Client.exists?(identifier: params[:identifier])
      {status: 403, body: "Identifier has already been taken"}
    elsif client.save
      {status: 200, body: {identifier: params[:identifier]}}
    else
      {status: 400, body: client.errors.full_messages.join(", ") }
    end
  end

  def self.post_with_payload(client, payload_request, params)
    if client.nil?
      {status: 403, body: "Application has not been registered"}
    elsif payload_request.nil?
      {status: 400, body: "Payload cannot be blank"}
    elsif payload_request.validates?
      {status: 200, body: "Payload received"}
    else
      {status: 403, body: "Payload has already been received"}
    end
  end

  # def determine_client_status(identifier)
  #   if Client.exists?(identifier: params[:identifier])
  #     status 403
  #     body  "Identifier has already been taken"
  #   elsif client.save
  #     status  200
  #     body "Client created"
  #   else
  #     status 400
  #     body client.errors.full_messages.join(", ")
  #   end
  # end
  #
  # def post_with_payload(client, payload_request)
  #   if client.nil?
  #     {status: 403, body: "Application has not been registered"}
  #   elsif payload_request.nil?
  #     {status: 400, body: "Payload cannot be blank"}
  #   elsif payload_request.validates?
  #     {status: 200, body: "Payload received"}
  #   else
  #     {status: 403, body: "Payload has already been received"}
  #   end
  # end

end
