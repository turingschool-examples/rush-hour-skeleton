module TrafficSpy
  class RegistrationParser
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def parsing_validating
      if identity && root
        user = User.new(identifier: identity, root_url: root)
        validate_and_save(user)
      else
        status, body = [400, "Missing all required details."]
      end
    end

    def validate_and_save(user)
      if user.save
        {'identifier' => identity}.to_json
      else
        status, body = [403, "Identifier already exists."]
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
