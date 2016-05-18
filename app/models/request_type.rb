class RequestType < ActiveRecord::Base
  has_many :payload_requests

  validates :name, presence: true

  def self.all_http_verbs
    self.uniq.pluck("name")
  end

  def self.most_frequent_request_type
    self.select("name").group("name").order("count_id DESC").limit(1).count("id").keys
  end
end
