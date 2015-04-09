module TrafficSpy
  class SourceHelper
    attr_accessor :status, :body

    def self.call(params)
      source = Source.new(root_url: params["rootUrl"], identifier: params["identifier"])
      if Source.find_by(identifier: source.identifier)
        @status = 403  
        @body = "Identifier already exists"
      elsif source.save
        @status = 200
        @body = JSON.generate({ :identifier => source.identifier })
      else
        @status = 400
        @body = source.errors.full_messages
      end
    end

    def self.status
      @status
    end

    def self.body
      @body
    end
  end
end