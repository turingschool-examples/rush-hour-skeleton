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
    if data.present?
      @data = InputConverter.conversion(data)
      @source = Source.new(@data).save
    else
      @data = {}
    end
  end

  def status
    if @data[:identifier].nil?
      400
    elsif @data[:root_url].nil?
      400
    elsif @data.save
      200
     else
      403
     end
  end

  def body
    status_messages[status]
  end

  def status_messages
    {
      200  => "Success",
      400  => "Parameters cannot be empty",
      403  => "Identifier has already been taken"
      }
  end

end
