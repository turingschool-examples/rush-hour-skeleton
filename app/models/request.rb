class Request < ActiveRecord::Base
  validates :request_type, presence: true

  has_many :payloads

  def self.list_all_http_verbs_used
    all_verbs = select(:request_type).distinct.group(:id)
    all_verbs.map { |verb| verb.request_type }
  end

  def self.most_frequent_request_type
    count = group(:request_type).count(:id)
    sorted_requests = count.sort_by { |request, count| count}.reverse
    sorted_requests.first.first
  end

end
