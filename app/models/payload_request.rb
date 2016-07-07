class PayloadRequest < ActiveRecord::Base
    # validates :url_id,            presence: true
    # validates :requested_at,      presence: true
    # validates :responded_in,      presence: true
    # validates :referred_by,       presence: true
    # validates :request_type,      presence: true
    # validates :user_agent,        presence: true
    # validates :resolution_id,     presence: true
    # validates :ip,                presence: true

    belongs_to :urls
    # belongs_to :requested_at
    belongs_to :referrers
    belongs_to :request_types
    # belongs_to :user_agent
    belongs_to :resolutions
    belongs_to :ips
end
