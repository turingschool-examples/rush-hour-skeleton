class Payload < ActiveRecord::Base
  belongs_to :url
  belongs_to :event
  belongs_to :referrer
  belongs_to :browser
  belongs_to :platform
  belongs_to :request_type
end
