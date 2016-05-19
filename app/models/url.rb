class Url < ActiveRecord::Base
  has_many :payload_requests

  validates :address, presence: true

  def self.list_urls_by_frequency
    select("address").group("address").order("count_id DESC").count("id").keys
  end

  def max_response_time
    payload_requests.maximum("responded_in")
  end

  def min_response_time
    payload_requests.minimum("responded_in")
  end

  def average_response_time
    payload_requests.average("responded_in")
  end

  def all_response_times_sorted
    payload_requests.order(responded_in: :DESC).pluck("responded_in")
  end

  def http_verbs_for_url
    payload_requests.pluck("request_type_id").uniq.map do |id|
      RequestType.find(id).name
    end
  end
end
