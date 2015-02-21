class MessageHelper
  class << self
    def send_message(message)
      if message.include?("taken")
        return 403, "403 Forbidden\n#{message}"
      else
        return 400, "400 Bad Request\n#{message}"
      end
    end
  end
end
