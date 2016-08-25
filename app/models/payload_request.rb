class PayloadRequest < ActiveRecord::Base
  belongs_to :urls
  belongs_to :sources
  belongs_to :request_types
  belongs_to :u_agents
  belongs_to :screen_resolutions

  validates :url_id, presence: true
  validates :requested_at, presence: true
  validates :responded_in, presence: true
  validates :source_id, presence: true
  validates :request_type_id, presence: true
  validates :u_agent_id, presence: true
  validates :screen_resolution_id, presence: true
  validates :ip_id, presence: true

  def self.average_response_time
    PayloadRequest.average(:responded_in).to_i
  end

  def self.max_response_time
    PayloadRequest.maximum(:responded_in).to_i
  end

  def self.min_response_time
    PayloadRequest.minimum(:responded_in).to_i
  end

  def self.url_max_response_time(id)
    requests  = PayloadRequest.where(url_id: id)
    requests.maximum(:responded_in).to_i
  end

  def self.url_min_response_time(id)
    requests  = PayloadRequest.where(url_id: id)
    requests.minimum(:responded_in).to_i
  end

  def self.url_response_times(id)
    requests  = PayloadRequest.where(url_id: id)
    requests.order('responded_in DESC').pluck(:responded_in)
  end

  def self.url_avg_response_time(id)
    requests  = PayloadRequest.where(url_id: id)
    requests.average(:responded_in).to_i
  end
end
