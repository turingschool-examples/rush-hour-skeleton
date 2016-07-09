class ClientChecker
  attr_reader :client

  def initialize(params)
    @client = Client.create(identifier: params["identifier"], root_url: params["rootUrl"])
  end

  def res
    # require 'pry'; binding.pry
    if client.save
      [200, "Sucess"]
    elsif client.errors.full_messages.join(', ') == "Identifier has already been taken"
      [403, 'Identifier Already Exists']
    else
      [400, client.errors.full_messages.join(', ')]
    end
  end

end
