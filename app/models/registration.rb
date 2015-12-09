module TrafficSpy
  class RegistrationParser

    def self.parsing_validating(params)
      if params[:identifier] && params[:rootUrl]
        user = User.new(identifier: params[:identifier], root_url: params[:rootUrl])
        if user.save
          id = params[:identifier]
          {'identifier' => id}.to_json
        else
          status, body = [403, "Identifier already exists."]
        end
      else
        status, body = [400, "Missing all required details."]
      end
    end

  end
end
