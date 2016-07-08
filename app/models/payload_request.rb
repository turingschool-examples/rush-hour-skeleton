class PayloadRequest < ActiveRecord::Base
  validates :url_id,               presence: true
  validates :requested_at,         presence: true
  validates :responded_in,         presence: true
  validates :referred_by_id,       presence: true
  validates :request_type_id,      presence: true
  validates :software_agent_id,    presence: true
  validates :ip_id,                presence: true
  validates :resolution_id,        presence: true
  validates :client_id,            presence: true

  belongs_to :url
  belongs_to :referrer, foreign_key: :referred_by_id
  belongs_to :request_type
  belongs_to :software_agent
  belongs_to :resolution
  belongs_to :ip
  belongs_to :client
  #
  # def referrer
  #   Referrer.find(self.referred_by_id)
  # end

end
