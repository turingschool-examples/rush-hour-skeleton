class PayloadParser
  attr_accessor :data, :message, :status_code

  def self.validate(data, identifier = nil)
    new(data, identifier)
  end

  def initialize(data, identifier = nil)
      @identifier = identifier
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
    elsif identifier_doesnt_exist?
      403
    elsif valid?
      200
    end
  end

  def body
    if application_duplicate?
      "this is duplicate request"
    elsif identifier_doesnt_exist?
      "application url does not exist"
    elsif valid?
      "success"
    end
  end

  def valid?
    data.present?
  end

  def application_duplicate?
    !@payload.save
  end

  def identifier_doesnt_exist?
    Source.where(identifier: @identifier).count == 0
  end

  def parse(data)
    InputConverter.conversion(JSON.parse(data[:payload]))
  end
end
