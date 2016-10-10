class Client < ActiveRecord::Base
  has_many :payloads
  has_many :agent, through: :payloads
  has_many :event, through: :payloads
  has_many :resolution, through: :payloads
  has_many :url, through: :payloads
  has_many :ip, through: :payloads
  has_many :request_type, through: :payloads
  has_many :referred_by, through: :payloads

  validates :identifier, presence: true, uniqueness: true
  validates :root_url, presence: true

  def average_response_time
    payloads.average_response_time
  end

  def max_response_time
    payloads.max_response_time
  end

  def min_response_time
    payloads.min_response_time
  end

  def most_frequent_request_type
    payloads.most_frequent_request_type
  end

  def all_request_types
    payloads.all_request_types
  end

  def urls_descending
    payloads.urls_descending
  end

  def browser_breakdown
    payloads.browser_breakdown
  end

  def os_breakdown
    payloads.os_breakdown
  end

  def resolutions_breakdown
    payloads.resolutions_breakdown
  end

end
