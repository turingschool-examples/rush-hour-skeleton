require 'byebug'

class IdentifierParser
  def self.validate(data)
      new(data)
    # end
    # check_for_keys

    # create identifier if everything looks good
    # check for identifier, check for root url
    # set instance variable for status
    # set instance variable for body
    # return IdentifierParser.new(identifier)
  end

  def initialize(data)
    @status = generate_status
    @body = assign_body[status]
    if params_exist?(data)
      formatted_data = InputConverter.conversion(data)
      @source = Source.new(formatted_data).save
    end
  end

  def params_exist?(data)
    false if data.nil? || data.empty?
  end

  def generate_status
    if @source[:identifier].nil?
      400
    elsif @source[:root_url].nil?
      400
    elsif @source.save
      200
     else
      403
     end
  end

  def assign_body
    {
      200  => "Success",
      400  => "Parameters cannot be empty",
      403  => "Identifier has already been taken"
      }
  end

end
