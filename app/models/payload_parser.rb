class PayloadParser
  attr_accessor :data, :message, :status_code

  def initialize(data={})
    @data = data
    @message = ""
    @status_code = ""
  end

  def self.valid?(data)
    if data.empty?
      message = "Payload is missing or empty"
      status_code = 400
      [message, status_code]
    end
  end

  def fdjhs
    if application_registered?
      []
    elsif valid?
      []
    end
  end

  def application_registered?
    if !payload.include?(Identifier.title.to_s)
      message = "Application is not registered"
      status_code = 403
      [message, status_code]
    end
  end

  def parse(data)
    InputConverter.conversion(JSON.parse(data[:payload]))
  end

# pull converter out to separate class so that functionality can be used for both source and payload

        #if PayloadPars
          #status 400
          #body identifier.errors.full_messages
        #elsif
          #payload = Payload.new(payload_data)
          #status 200
          #body "success"
        ##elsif identifier.title.nil?
          ##status 400
          ##body identifier.errors.full_messages
        #else
          #status 403
          #body payload.errors.full_messages
        #end

end
