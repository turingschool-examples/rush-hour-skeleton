module Response
  extend self

  def process_client(client, client_identifier)
    if Client.find_by(identifier: client_identifier)
      {status: 403, body: "Identifier #{client_identifier} already exists\n"}
    elsif client.save
      {status: 200, body: "{'identifier':'#{client_identifier}'}\n"}
    else
      {status: 400, body: "#{client.errors.full_messages.join("\n")}\n"}
    end
  end

  def process_data(params, identifier)
    client = Client.find_by(identifier: identifier)
    if client.nil?
      {status: 403, body: "Client #{identifier} is not registered\n"}
    elsif params[:payload].nil?
      {status: 403, body: "Missing parameters\n"}
    elsif Processor.does_payload_exist?(params[:payload], client)
      {status: 403, body: "Payload already exists\n"}
    else
      data_responder(client, params)
    end
  end

  def data_responder(client, params)
    clean_data = Processor.params_cleaner(params[:payload])
    pl = client.payload.create(clean_data)

    if pl.save
      {status: 200, body: "OK\n"}
    else
      {status: 400, body: "#{client.payload.errors.full_messages.join("\n")}\n"}
    end
  end
end
