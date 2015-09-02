class VisitMessenger

  attr_reader :record

  def initialize(params, model)
    attributes = {}
    attributes[:root_url] = params[:rootUrl] #Dynamically build attributes & snake case
    attributes[:identifier] = params[:identifier]
    @record = model.constantize.new(attributes) #Dynamically call model
    record.save if valid_record
  end

  def message
    if valid_record
      return_value = {:identifier => record.identifier}.to_json #dynamically build
      return_value
    elsif error == "can't be blank"
      "Missing Parameters: #{specific_error}"
    elsif error == "has already been taken"
      "Non-unique Value: #{specific_error}"
    end
  end

  def status
    if valid_record
      "200 OK"
    elsif error == "can't be blank"
      "400 Bad Request"
    elsif error == "has already been taken"
      "403 Forbidden"
    end
  end

  private

  def valid_record
    record.valid?
  end

  def error
    record.errors.messages.values.flatten.first
  end

  def specific_error
    record.errors.full_messages.first
  end

end