class Url < ActiveRecord::Base
  has_many :payloads
  has_many :request_types, through: :payloads
  has_many :refers, through: :payloads

  validates :address, presence: true, uniqueness: true

  def self.list_frequency_urls
    self.joins(:payloads).group("urls.address").order(count: :desc).count
    # take out joins if you see squared numbers
  end

  def max_url_response_time
    payloads.max_response_time
  end

  def min_url_response_time
    payloads.min_response_time
  end

  def list_url_response_times
    payloads.order(response_time: :desc).pluck(:response_time)
  end

  def average_url_response_time
    payloads.average_response_time
  end

  def show_all_url_verbs
    request_types.pluck(:verb)
  end

  def three_most_popular_url_refers
    refers.group("address").order(count: :desc).count.keys
    # what happens if theres a tie?
  end
end
