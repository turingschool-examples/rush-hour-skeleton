class ClientAnalyzer

  def parse(raw_request)
    error = nil
    identifier = raw_request[:identifier]
    root_url = raw_request[:rootUrl]

    client = Client.create(identifier: identifier, root_url: root_url)
    if client.errors.any?
      error = client.errors.full_messages.join(", ")
    end
    
    return error
  end

end
