class Messenger

  attr_reader :record, :model

  def initialize(params, model)
    @model = model
    attribute_array = params.to_a.map do |key, value|
      [key.to_s.underscore.to_sym, value]
    end
    attributes = attribute_array.to_h
    @record = eval(model).new(attributes)
    record.save if valid_record
  end

  def message
    if valid_record
      return_value = {:identifier => record.identifier}.to_json #dynamically build
      return_value if model == "Source"
    elsif error == "can't be blank"
      "Missing Parameters: #{specific_error}"
    elsif error == "has already been taken"
      "Non-unique Value: #{specific_error}"
    end
  end

  def status
    if valid_visit
      "200 OK"
    else
      "403 Forbidden"
    end
  end

  private

  def valid_visit
    vist.valid?
  end

  def error
    visit.errors.messages.values.flatten.first
  end

  def specific_error
    visit.errors.full_messages.first
  end

  def underscore
    self.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    downcase
  end

end
