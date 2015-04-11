require 'byebug'

class IdentifierParser
  def self.validate(data)
      new(data)
  end

  def initialize(data)
    byebug
    if data.present?
      @data = InputConverter.conversion(data)
      @source = Source.new(@data)
    else
      @data = {}
    end
  end

  def status
    if @data[:identifier].nil?
      400
    elsif @data[:root_url].nil?
      400
    elsif @source.save
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
