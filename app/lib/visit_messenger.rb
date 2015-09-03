class VisitMessenger

  attr_reader :visit

  def initialize(params)
    attributes = JSON.parse(params[:payload])
    attributes_s = attributes.to_s
    #Keys are currently strings and need to be changed to symbols
    require 'pry'; binding.pry
    sha_identifier = Digest::SHA1.hexdigest(attributes_s)
    attributes[:sha_identifier] = sha_identifier
    @visit =Visit.new(attributes)
  end

  def message
    if !valid_visit
      "Payload Has Already Been Received"
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

end