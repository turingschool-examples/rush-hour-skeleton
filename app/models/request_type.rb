class RequestType < ActiveRecord::Base
  has_many :payload_requests

  validates :verb, presence: true

  def self.all_verbs
    pluck(:verb)
  end
end
