class ClientParser
  def parse_client(params)
    client =
    Client.new(:identifier => params["identifier"], root_url: params["rootUrl"])
    if client.save
      [200, {"identifier": "#{client.identifier}"}.to_json]
    elsif client.errors.full_messages.include?("Identifier has already been taken")
      [403, "Please choose an identifier that's not already in use."]
    else
      [400, "Please provide both an identifier and root url parameter."]
    end
  end
end
