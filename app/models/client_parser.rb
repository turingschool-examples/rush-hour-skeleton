class ClientParser

  def initialize(data)
    if data.nil?
      @data = {}
    else
      @data = JSON.parse(data)
    end
  end

  def parse
    {
      identifier: @data["identifier"],
      root_url: @data["rootUrl"]
    }
  end

  def self.parse(data)
    new(data).parse
  end
end
