class RequestType < ActiveRecord::Base
  validates :verb, presence: true
  has_many :payload_requests

  def self.all_http_verbs_used
    # all.map { |rt| rt.verb }
    pluck(:verb)
  end
end
