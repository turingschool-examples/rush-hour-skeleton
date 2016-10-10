class Client < ActiveRecord::Base
  has_many :payload
  has_many :agent, through: :payload
  has_many :event, through: :payload
  has_many :resolution, through: :payload
  has_many :url, through: :payload
  has_many :ip, through: :payload
  has_many :request_type, through: :payload
  has_many :referred_by, through: :payload

  validates :identifier, presence: true, uniqueness: true
  validates :root_url, presence: true

  def average_response_time
    payload.average_response_time
  end

  def max_response_time
    payload.max_response_time
  end

  def min_response_time
    payload.min_response_time
  end

  def most_frequent_request_type
    payload.most_frequent_request_type
  end

  def all_request_types
    payload.all_request_types
  end

  def urls_descending
    payload.urls_descending
  end

  def browser_breakdown
    payload.browser_breakdown
  end

  def os_breakdown
    payload.os_breakdown
  end

  def resolutions_breakdown
    payload.resolutions_breakdown
  end

end
