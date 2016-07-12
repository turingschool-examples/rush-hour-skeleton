class RequestType < ActiveRecord::Base
  validates :verb, presence: true, uniqueness: true

  has_many :payload_requests

  def self.verb_list
    pluck(:verb)
  end
end
