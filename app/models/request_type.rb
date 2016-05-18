class RequestType < ActiveRecord::Base
  validates "request_type", presence: true

  belongs_to :payload_requests

  def self.all_verbs
    self.all.map { |verb| verb.request_type }
  end

  def self.most_frequent_request_verbs
    # self.all.max_by do |rtype|
    #   rtype.payload_requests.count
    # end
    # binding.pry
    self.group(:request_type).count
  end
end
