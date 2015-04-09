class ClientValidator < Client

  def self.validate(data)
    info = ClientParser.parse(data)
    client = Client.new(info)
    if client.save  # Refactor if we have time
      json_body = JSON.generate({"identifier"=>client.identifier})
      # binding.pry
      {code: 200, message: json_body}
    elsif Client.find_by(identifier: client.identifier)
      errors = client.errors.full_messages
      {code: 403, message: errors}
    else
      errors = client.errors.full_messages
      {code: 400, message: errors}
    end

  end

end
