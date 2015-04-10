module TrafficSpy
  class ClientParser

    def initialize(data)
      if data.nil?
        @data = {}
      else
        @data = data
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
end
