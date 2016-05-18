class PayloadRequest < ActiveRecord::Base
 validates  "url_id",
            "requested_at",
            "responded_in",
            "reference_id",
            "request_type_id",
            "parameters",
            "event_name_id",
            "software_agent_id",
            "resolution_id",
            "ip_address_id", presence: true
  has_many :urls
  has_many :references
  has_many :request_types
  has_many :event_names
  has_many :software_agents
  has_many :resolutions
  has_many :ip_addresses

  def self.average_response_time

    self.average(:responded_in)
  end

end
#each validation on its own line so that each attribute can be clearly showed seperately (will add validations later)
#might want to validate something like the url end with ...
