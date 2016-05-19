class RequestType < ActiveRecord::Base
  validates :request_type, presence: true

  has_many :payload_requests
  has_many :urls, through: :payload_requests

  def self.all_verbs
    self.pluck(:request_type)
  end

  def self.most_frequent_request_verbs
    self.all.max_by do |rtype|
      rtype.payload_requests.count
    end.request_type
  end
end
