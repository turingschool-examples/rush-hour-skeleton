class UserRegistrator
  attr_reader :message

  def initialize(message)
    @message = message
  end

  def error_status
    if message.include?("can't be blank")
      400
    else
      403
    end
  end

  def error_message
    if message.include?("can't be blank")
      "Bad Request - #{message.first} can't be blank."
    else
      "Forbidden - identifier has already been taken."
    end
  end
end