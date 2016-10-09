require 'pry'
module Response
  extend self

  def process_client(client, client_identifier)
    # 1. If client identifier exsits, return 403
    # 2. If client can be saved, save
    # 3. Return any type of ActiveRecord messages that appear

    if Client.find_by(identifier: client_identifier)
      {status: 403, body: "Identifier #{client_identifier} already exists\n"}
    elsif client.save
      {status: 200, body: "{'identifier':'#{client_identifier}'}\n"}
    else
      {status: 400, body: "#{client.errors.full_messages.join("\n")}\n"}
    end
  end


end
