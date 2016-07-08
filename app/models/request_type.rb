class RequestType < ActiveRecord::Base
  validates :verb, presence: true
  has_many :payload_requests
  # list all verbs used in addition to calculating the most common
  def self.frequent_request_types
    pluch(:verb).all.max_by do |verb|
      verb.count
    end
  end

  def self.all_http_verbs_used
    pluck(:verb).uniq
  end
end
