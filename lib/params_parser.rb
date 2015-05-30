module TrafficSpy
  class ParamsParser
    attr_reader :payload, :url, :sha

    def initialize(payload, sha)
      @payload = JSON.parse(payload) 
      @url = payload['url']
      @sha = sha
    end

    def parse
      Payload.create({sha: sha})
      Page.create({url: url}) 
    end
  end
end
