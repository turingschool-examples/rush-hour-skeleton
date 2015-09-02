class SourceMessenger

  attr_reader :source

  def initialize(params)
    source_attributes = {}
    source_attributes[:root_url] = params[:rootUrl]
    source_attributes[:identifier] = params[:identifier]
    @source = Source.new(source_attributes)
    source.save if valid_source
  end

  def message
    if valid_source
      return_value = {:identifier => source.identifier}.to_json
      return_value
    elsif error == "can't be blank"
      "Missing Parameters: #{specific_error}"
    elsif error == "has already been taken"
      "Non-unique Value: #{specific_error}"
    end
  end

  def status
    if valid_source
      "200 OK"
    elsif error == "can't be blank"
      "400 Bad Request"
    elsif error == "has already been taken"
      "403 Forbidden"
    end
  end

  private

  def valid_source
    source.valid?
  end

  def error
    source.errors.messages.values.flatten.first
  end

  def specific_error
    source.errors.full_messages.first
  end

end