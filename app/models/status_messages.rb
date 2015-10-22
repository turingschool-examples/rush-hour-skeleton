class StatusMessages
  def self.status_message(source)
    if source.errors.full_messages.join(", ") == "Identifier has already been taken"
      return 403
    elsif source.errors.full_messages.join(", ") == "Root url can't be blank"
      return 400
    elsif source.errors.full_messages.join(", ") == "Identifier can't be blank"
      return 400
    elsif source.errors.full_messages.join(", ") == "Hex digest has already been taken"
      return 403
    end
  end

  def self.blank_payload
    return 400
  end

  def self.blank_identifier
    return 403
  end
end
