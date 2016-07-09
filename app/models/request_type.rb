class RequestType < ActiveRecord::Base
  validates :verb, presence: true, uniqueness: true
  has_many :payload_requests

  def self.all_verbs_used
    RequestType.all.pluck(:verb)
  end

end
