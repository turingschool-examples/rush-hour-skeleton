class Payload < ActiveRecord::Base
  belongs_to :request_type
  belongs_to :screen_resolution
  belongs_to :event_name
  belongs_to :url
  belongs_to :ip
  belongs_to :user_agent
  belongs_to :referred
  belongs_to :client
  validates :request_type_id, presence: true
  validates :screen_resolution_id, presence: true
  validates :event_name_id, presence: true
  validates :url_id, presence: true
  validates :ip_id, presence: true
  validates :user_agent_id, presence: true
  validates :referred_id, presence: true

  def self.average_response_time
    self.average(:responded_in)
  end

  def self.max_response_time
    self.maximum(:responded_in)
  end

  def self.min_response_time
    self.minimum(:responded_in)
  end

end
