class EventName < ActiveRecord::Base
  has_many :payloads
end
