class StatusHelper
  attr_reader :message

  def initialize(message)
    @message = message
  end

  def status
    if message.include? "taken"
      return 403
    else
      400
    end
  end
end
