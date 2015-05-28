class PayloadCreator
  attr_accessor :status, :body

  def initialize(payload, client)
    @status = 0
    @body = ""
    make(payload, client)
  end

  def make(payload, client)
    if payload == nil
      @status = 400
      @body = "Payload missing"
    elsif client == []
      @status =  403
      @body = "URL not recognized"
    elsif client.first.root_url == webroot(payload)
      @status = 200
    end
  end

  def webroot(payload)
    data = JSON.parse(payload)
    website = URI(data["url"])
    website.scheme + "://" + website.host
  end



end
