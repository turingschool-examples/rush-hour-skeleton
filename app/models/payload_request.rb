class PayloadRequest < ActiveRecord::Base
  belongs_to :url
  validates :url_id, presence: true
  validates :requested_at, presence: true
  validates :responded_in, presence: true
  validates :source_id, presence: true
  validates :request_type_id, presence: true
  validates :u_agent_id, presence: true
  validates :screen_resolution_id, presence: true
  validates :ip_id, presence: true
end
