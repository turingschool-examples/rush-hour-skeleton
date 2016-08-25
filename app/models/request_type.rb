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

  def self.request_type_id_associated_with_url(address)
    url = Url.find_by(:address => address)
    PayloadRequest.where(:url_id => url.id).group('request_type_id').count
  end

  def self.verbs_associated_with_url(address)
    grouping = request_type_id_associated_with_url(address)
    grouping.to_a.map do |request_type_id_count|
      [RequestType.find_by(:id => request_type_id_count[0]).verb,
       request_type_id_count[1]]
    end.to_h
  end
end
