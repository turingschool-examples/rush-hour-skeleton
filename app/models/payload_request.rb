class PayloadRequest < ActiveRecord::Base
 validates  "url",
            "requested_at",
            "responded_in",
            "referred_by",
            "request_type",
            "parameters",
            "event_name",
            "user_agent",
            "resolution_width",
            "resolution_height",
            "ip", presence: true
end
#each validation on its own line so that each attribute can be clearly showed seperately (will add validations later)
#might want to validate something like the url end with ...
