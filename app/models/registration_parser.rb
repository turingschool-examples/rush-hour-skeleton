module TrafficSpy
  class RegistrationParser
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def parsing_validating
      if identity && root
        user = User.new(identifier: identity, root_url: root)
        if user.save
          {'identifier' => identity}.to_json
        else
          status, body = [403, "Identifier already exists."]
        end
      else
        status, body = [400, "Missing all required details."]
      end
    end

    def identity
      params["identifier"]
    end

    def root
      params["rootUrl"]
    end


  end
end
