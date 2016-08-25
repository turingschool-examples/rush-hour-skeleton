class RequestType < ActiveRecord::Base
  has_many :payload_requests

  validates :verb, presence: true
  validates :verb, uniqueness: true

  def self.most_frequent_request_type
    grouping = group_by_request_type
    RequestType.find_by(:id => grouping[grouping.keys.max]).verb
  end

  def self.list_verbs
    RequestType.pluck(:verb)
  end

  def self.group_by_request_type
    PayloadRequest.group('request_type_id').count
  end
end
