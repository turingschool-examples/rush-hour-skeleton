class EventName < ActiveRecord::Base
  belongs_to :payload_requests
end
