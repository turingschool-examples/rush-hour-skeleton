class RegistrationHandler

  def initialize(input)
    @reg_data = input
  end

  def status
    400
  end

  def body
    "Missing Parameters - 400 Bad Request"
  end

end
