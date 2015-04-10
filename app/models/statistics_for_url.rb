
class StatisticsForUrl < ActiveRecord::Base

  def initialize(identifier)
    @identifier = identifier
    @client_id  = Client.find_by(identifer: identifier).id
  end

  def get_stats
    {longest: longest_response}
  end

  def longest_response
    Payload.where(client_id: @client_id).pluck(:responded_in)
  end

  def self.get_stats(identifier)
    new(identifier).get_stats
  end

end