class Payload < ActiveRecord::Base
  validates  :requested_at, presence: true
  validates  :response_time, presence: true
  validates  :parameters, presence: true
  # has many parameters
  belongs_to :event
  belongs_to :ip
  belongs_to :refer
  belongs_to :resolution
  belongs_to :url
  belongs_to :user_environment
  belongs_to :request_type

  def self.average_response_time
    self.average(:response_time).to_f
  end

  def self.min_response_time
    self.minimum(:response_time)
  end

  def self.max_response_time
    self.maximum(:response_time)

  end

  def self.most_frequent_request_type
  self.maximum(:request_type_id)
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
