module ResponseMessages

  def client_response_decider
    client = Client.new(identifier: params[:identifier], root_url: params[:rootUrl])
    client_sha = create_sha(params)
    if client_sha_exists?(client)
      response_client_already_exists
    else
      if client.save
        response_client_created
      else
        response_list_all_client_errors
      end
    end
  end

  def payload_response_decider(payload)
    if payload_sha_exists?(payload)
      response_payload_already_exists
    elsif bad_url?(params)
      response_payload_contains_bad_url
    else
      if payload.save
        response_payload_created
      else
        response_list_all_payload_errors
      end
    end
  end

  def response_payload_already_exists
    response.status = 403
    response.body = "Payload already exists"
  end

  def response_payload_contains_bad_url
    response.status = 403
    response.body = "Payload contains URL that doesn't exist"
  end

  def response_payload_created
    response.status = 200
    response.body = "Payload created"
  end

  def response_list_all_payload_errors
    response.status = 400
    payload.errors.full_messages.join(", ")
  end

  def response_client_already_exists
    response.status = 403
    response.body = "Client already exists"
  end

  def response_client_created
    response.status = 200
    response.body = "Client created"
  end

  def response_list_all_client_errors
    response.status = 400
    response.body = client.errors.full_messages.join(", ")
  end
end
