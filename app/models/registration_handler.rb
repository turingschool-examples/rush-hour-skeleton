module TrafficSpy
  class RegistrationHandler
    attr_reader :registration, :status, :body
    def initialize(params)
      @registration = params
    end

    def call
      require 'pry'
      binding.pry
      reg = Registration.new({ identifier: registration["identifier"], url: registration["rootUrl"] })
      if registration["identifier"] == nil || registration['rootUrl'] == nil
        @status = 400
        @body = "Missing Parameters - 400 Bad Request"
      else
        if reg.save
          @status = 200
          @body = "{'identifier' : '#{registration['identifier']}'}"
        else
          @status = 403
          @body = "Identifier Already Exists - 403 Forbidden"
        end

      end
    end
  end
end
