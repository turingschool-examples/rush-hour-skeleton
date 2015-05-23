class ClientValidator < Client
  
  def self.validate(data) 
    client = Client.new(data)
    
    if client.save  # Refactor if we have time
      json_body = JSON.generate({identifier:data["identifier"]})
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