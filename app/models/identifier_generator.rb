class IdentifierGenerator
  attr_reader :status, :message
  def initialize(status, message)
    @status  = status
    @message = message
  end

  def self.call(params)
    source = Source.new(params)
    if source.save
      IdentifierGenerator.new(200, source.simplified_json)
    elsif source.error_response.include? "take"
      IdentifierGenerator.new(403, source.error_response)
    else
      IdentifierGenerator.new(400, source.error_response)
    end
  end
end
