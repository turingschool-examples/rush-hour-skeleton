module TrafficSpy
  class PayloadValidator < Payload

    def self.validate(data, identifier)
      info        = PayloadParser.parse(data, identifier)
      payload     = Payload.new(info)
      payload_nil = info.each_value.all? {|value| value.nil?}
      
      if payload_nil
        {code: 400, message: "Payload cannot be nil"}
      elsif payload.save
        {code: 200}
      elsif Payload.find_by(composite_key: payload.composite_key)
        errors = payload.errors.full_messages
        {code: 403, message: errors}
      elsif payload.tracked_site_id == nil
        errors = payload.errors.full_messages
        {code: 403, message: errors}
      else
        errors = payload.errors.full_messages
        {code: 400, message: errors}
      end

    end

  end
end
