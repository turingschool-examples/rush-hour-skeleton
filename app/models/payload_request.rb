class PayloadRequest < ActiveRecord::Base
  #presumably will put in this space belongs_to :url, etc., all the class names, once we make those.
  # belongs_to :url
  # belongs_to :request_type
  # belongs_to :resolution
  # belongs_to :ip
  # belongs_to :user_agent
  # belongs_to :referred_by

  validates :url, presence: true
  validates :requested_at, presence: true
  validates :responded_in, presence: true
  validates :referred_by, presence: true
  validates :request_type, presence: true
  validates :user_agent, presence: true
  validates :resolution_width, presence: true
  validates :resolution_height, presence: true
  validates :ip, presence: true

end
