class Payload < ActiveRecord::Base
  validates :ip, uniqueness: { scope: :requested_at,
  message: "Application has already been received" }
end
