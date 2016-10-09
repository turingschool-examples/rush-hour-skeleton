class Url < ActiveRecord::Base
  validates :url_address, presence: true
  validates :url_address, uniqueness: true

  has_many :payloads


  def self.most_to_least_requested
    Url.joins(:payloads).group(:url_address).order("COUNT(payloads.*) DESC").pluck(:url_address)
  end

#note that these aren't ``.self` methods (class methods) because they reference a specific url, and not the class Url.

  def max_response_time(url)
    url.payloads.maximum("responded_in")
  end

  def min_response_time(url)
    url.payloads.minimum("responded_in")
  end

  def average_response_time(url)
    url.payloads.average("responded_in")
  end

  def longest_to_shortest_response_time

  end

  def list_of_http_verbs

  end

  def three_most_popular_referrers

  end

  def three_most_popular_user_agents

  end

end
