class ReferredBy < ActiveRecord::Base
  belongs_to :payload_requests
end
