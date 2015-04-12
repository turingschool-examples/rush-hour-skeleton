module TrafficSpy
  class ClientParser

    def initialize(data)
      @data = data
    end

    def parse
      {
       identifier: @data["identifier"],
       root_url: @data["rootUrl"]
      }
    end

    def self.parse(data = {})
      new(data).parse
    end
    
  end
end
