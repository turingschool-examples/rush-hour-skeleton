class RequestType < ActiveRecord::Base
  has_many :payload_requests

  validates :verb, presence: true

  def self.most_frequest_request_type
    group(:verb).count.keys.reverse[0]
  end

  def self.all_verbs
    uniq.pluck(:verb)
  end
end
