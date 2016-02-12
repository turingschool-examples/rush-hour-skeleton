class Url < ActiveRecord::Base
  has_many :payloads

  validates :address, presence: true, uniqueness: true

  def self.list_frequency_urls
    self.joins(:payloads).group("urls.address").order(count: :desc).count
  end

  def self.max_response_time_given_url(single_url)
    self.joins(:url).where("address = ?", single_url).maximum(:response_time)
    # payloads.pluck(:response_time).max - something like this
  end

  def self.min_response_time_given_url(single_url)
    self.joins(:url).where("address = ?", single_url).minimum(:response_time)
  end

  def self.all_response_times_given_url(single_url)
    self.joins(:url).where("address = ?", single_url).order(:response_time).reverse_order.pluck(:response_time)
  end

  def self.average_response_time_given_url(single_url)
    self.joins(:url).where("address = ?", single_url).average(:response_time).to_f
  end

  def self.verbs_given_url(single_url)
    self.joins(:url).where("address = ?", single_url).joins(:request_type).pluck(:verb)
  end

  def self.three_most_popular_referrers(single_url)
      # self.select("url(address) as url_address, refer(address) as refer_address")
      self.joins(:url).where("url(address) as url_address = ?", single_url).joins(:refer).order("count_address desc").count(" address")
      url.refers.max.take(3)
  end
end
