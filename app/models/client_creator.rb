class ClientCreator
  attr_accessor :status, :body

  def initialize(params)
    make(params)
  end

  def make(params)
    client = Client.new({identifier: params[:identifier], root_url: params[:rootUrl]})
    if client.save
      @status = 200
      @body = "{'identifier':'#{client.identifier}'}"
    else
      checker(client)
    end
  end

  def checker(client)
    if Client.exists?(identifier: client.identifier)
      @status = 403
      @body = "Identifier already exists"
    elsif client.identifier == nil && client.root_url == nil
      @status = 400
      @body = "Please enter an identifier and rootUrl"
    elsif client.root_url == nil
      @status = 400
      @body = "Make sure you enter a rootUrl"
    else
      @status = 400
      @body = "Make sure you enter an identifier"
    end
  end

end
