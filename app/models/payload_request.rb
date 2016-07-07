class PayloadRequest < ActiveRecord::Base
  #presumably will put in this space belongs_to :url, etc., all the class names, once we make those.
  # belongs_to :url
  # belongs_to :request_type
  # belongs_to :resolution
  # belongs_to :ip
  # belongs_to :user_agent
  # belongs_to :referred_by

  validates :url_id, presence: true
  validates :requested_at, presence: true
  validates :responded_in, presence: true
  validates :referred_by_id, presence: true
  validates :request_type_id, presence: true
  validates :u_agent_id, presence: true
  validates :resolution_id, presence: true
  validates :ip_id, presence: true

end
