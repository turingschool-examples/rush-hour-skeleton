class RequestType < ActiveRecord::Base
  validates :verb,      presence: true

  has_many :payload_requests

  def self.most_frequent_type
    values = RequestType.pluck(:verb)
    values.group_by(&:itself).values.max_by(&:size).first
  end

end
