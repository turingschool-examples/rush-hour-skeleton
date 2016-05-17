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
