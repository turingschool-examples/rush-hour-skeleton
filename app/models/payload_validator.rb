class PayloadValidator < Payload
  
  def self.validate(data) 
    payload = Payload.new(data)
    # user_payloads = Payload.where()
    
    if payload.save  
      # json_body = JSON.generate()
      require 'pry'
      binding.pry
      {code: 200, message: "testing"}
    elsif Payload.find_by(requestedAt: payload.requested_at)
      errors = payload.errors.full_messages
      {code: 403, message: errors}
    else
      errors = payload.errors.full_messages
      {code: 400, message: errors}
    end  
  
  end

end