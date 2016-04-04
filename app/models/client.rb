class Client < ActiveRecord::Base
  has_many :payload_requests
  has_many :referrers, through: :payload_requests
  has_many :request_types, through: :payload_requests
  has_many :u_agents, through: :payload_requests
  has_many :urls, through: :payload_requests
  has_many :resolutions, through: :payload_requests
  has_many :events, through: :payload_requests

  validates :identifier, presence: true, uniqueness: true
  validates :root_url, presence: true


  def most_requested_verb
    request_types.group(:verb).order(count: :desc).count.keys.first
  end

  def max_response_time
    payload_requests.maximum(:responded_in)
  end

  def min_response_time
    payload_requests.minimum(:responded_in)
  end

  def all_response_time_from_most_to_least
    payload_requests.pluck(:responded_in).sort.reverse
  end

  def average_response_time
    payload_requests.average(:responded_in).to_f
  end

  def list_all_verbs
    request_types.pluck(:verb).uniq
  end

  def list_top_three_referrers
    referrers.group(:address).order(count: :desc).count.keys.take(3)
  end

  def list_top_three_u_agents
    u_agents.group(:browser, :platform).order(count: :desc).count.keys.take(3)
  end

  def most_to_least_frequent_urls
    urls.group(:address).order(count: :desc).count.keys
  end

  def browsers
    u_agents.pluck(:browser).uniq
  end

  def platforms
    u_agents.pluck(:platform).uniq
  end

  def screen_resolutions
    rez = resolutions.pluck(:width, :height).uniq
    rez.map {|pair| "#{pair[0]}x#{pair[1]}"}
  end

  def find_payload_requests_by_relative_path(path)
    payload_requests.where(url: Url.find_by(address: path))
  end
end
