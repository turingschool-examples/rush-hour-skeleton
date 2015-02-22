class Payload < ActiveRecord::Base
  belongs_to :url
  belongs_to :referred_by
  belongs_to :request_type
  belongs_to :ip_address
  belongs_to :event
  belongs_to :resolution
  belongs_to :browser
  belongs_to :os
  belongs_to :source
  belongs_to :identifier
end
