class Payload < ActiveRecord::Base
  belongs_to :browser
  belongs_to :request_type
  belongs_to :os
  belongs_to :screen_resolution
end
