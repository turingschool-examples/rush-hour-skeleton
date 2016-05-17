class PayloadRequest < ActiveRecord::Base
 validates  "url_id",
            "requested_at",
            "responded_in",
            "referred_by_id",
            "request_type_id",
            "parameters",
            "event_name_id",
            "user_agent_id",
            "resolution_id",
            "ip_address_id", presence: true
  has_many :urls
  has_many :referred_bys
  has_many :request_types
  has_many :event_names
  has_many :user_agents
  has_many :resolutions
  has_many :ip_addresses
end
#each validation on its own line so that each attribute can be clearly showed seperately (will add validations later)
#might want to validate something like the url end with ...
