class Url < ActiveRecord::Base

  has_many :payloads
  has_many :request_types, through: :payloads

  validates :url, presence: true

  def all_response_times_by_url
    payloads.reduce([]) do |result, payload|
      result << payload.responded_in
    end.sort.reverse
  end

  def max_response_time_by_url
    all_response_times_by_url.max
  end

  def min_response_time_by_url
    all_response_times_by_url.min
  end

  def average_response_time_by_url
    all_response_times_by_url.reduce(:+)/all_response_times_by_url.length
  end

  def self.http_verbs_by_url(input_url)
    url = Url.find_by(url: input_url)
    url.request_types.reduce([]) do |result, request_row|
      result << request_row.request_type
      result
    end
  end

  def self.most_to_least_requested(payloads)
    order = payloads.order('url_id DESC')
    order.reduce([]) do |result, object|
      result << object.url.url
      result
    end.uniq
  end

end
