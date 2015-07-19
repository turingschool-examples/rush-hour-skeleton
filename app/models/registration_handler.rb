class RegistrationHandler
  attr_reader :identifier,
              :root_url,
              :status,
              :body

  def initialize(input)
    @reg_data = input
    process(input['identifier'], input['rootUrl'])
  end

  def process(identifier, root_url)

    if valid_input?(identifier, root_url)
      reg = Registration.new({ identifier: identifier, url: root_url })

      if reg.save
        set_return_values(200, "{'identifier' : '#{identifier}'}")
      else
        set_return_values(403, "Identifier Already Exists - 403 Forbidden")
      end

    else
      set_return_values(400, "Missing Parameters - 400 Bad Request")
    end

  end

  def valid_input?(identifier, root_url)
    !(identifier.nil? || root_url.nil?)
  end

  def set_return_values(status, body)
    @status = status
    @body   = body
  end

end
