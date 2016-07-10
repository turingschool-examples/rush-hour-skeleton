class Client < ActiveRecord::Base
  has_many :payload_requests
  has_many :ips, through: :payload_requests
  has_many :referrers, through: :payload_requests
  has_many :request_types, through: :payload_requests
  has_many :resolutions, through: :payload_requests
  has_many :urls, through: :payload_requests
  has_many :software_agents, through: :payload_requests
  has_many :parameters, through: :payload_requests

  validates :identifier, presence: true, uniqueness: true
  validates :root_url, presence: true, uniqueness: true

  def error_message
    errors.full_messages.join(", ")
  end

  def max_response_time
    payload_requests.maximum(:responded_in)
  end

  def min_response_time
    payload_requests.minimum(:responded_in)
  end

  def average_response_time
    payload_requests.average(:responded_in).to_i
  end

  def list_of_all_http_verbs_used
    request_types.pluck(:verb).uniq
  end

  def most_frequent_request_type
    request_types.group(:verb).order(count: :desc).count.keys.first
  end

  def list_urls_from_most_to_least
    url_id = payload_requests.pluck(:url_id).sort.last
    urls.find_by(id: url_id).address
  end

  def web_browser_breakdown
    software_agents.group(:browser).order(count: :desc).count.keys
  end

  def web_os_breakdown
    software_agents.group(:os).order(count: :desc).count.keys
  end

  def all_screen_resolutions
    res = resolutions.pluck("width, height").uniq
    res.map { |r| "#{r.first} X #{r.last}" }
  end

  def find_url_by_relative_path(relative_path)
    full_path = root_url + "/" + relative_path
    urls.find_by(address: full_path)
  end

  def relative_path_exists?(relative_path)

    full_path = root_url + "/" + relative_path
    !!urls.find_by(address: full_path)
  end
end
