class Request < ActiveRecord::Base
  validates :request_type, presence: true

  has_many :payloads

  def self.list_all_http_verbs_used
    all_verbs = select(:request_type).distinct.group(:id)
    all_verbs.map { |verb| verb.request_type }
  end
end
