class PayloadParser
  attr_accessor :data, :message, :status_code

  def self.validate(data)
    new(data)
  end

  def initialize(data)
    if data.present?
      @data = InputConverter.conversion(data)
      @payload = Payload.new(@data)
    else
      @data = {}
    end
  end

  def status
    if application_duplicate?
      403
    elsif valid?
      200
    end
  end

  def body
    status_messages[status]
  end

  def status_messages
    {
      403 => "Payload is missing or empty",
      200 => "success"
    }
  end

  def valid?
    data.present?
  end

  def application_duplicate?
    !@payload.save
  end

  #def identifier_exists?
    #account = params[:identifier]??
    #if Source.identifiers.any? do |identifier|
      #identifier == account
    #end
    #if identifier.include?(Source.identifier.to_s)
      #message = "Application is not registered"
      #status_code = 403
      #[message, status_code]
    #end
  #end

  def parse(data)
    InputConverter.conversion(JSON.parse(data[:payload]))
  end
end
