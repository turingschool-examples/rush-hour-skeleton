class RequestType < ActiveRecord::Base
  has_many :payload_requests

  validates :http_verb, presence: true
  validates :http_verb, uniqueness: true

  def self.list_all_verbs
    joins(:payload_requests).pluck(:http_verb)
  end

  def self.most_frequent_request
    joins(:payload_requests).group(:http_verb).count(:http_verb)
  end
end
