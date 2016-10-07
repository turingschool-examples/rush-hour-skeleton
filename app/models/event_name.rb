class EventName < ActiveRecord::Base

  validates :event_name, presence: true

end
