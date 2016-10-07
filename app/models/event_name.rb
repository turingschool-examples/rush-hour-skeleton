class Event < ActiveRecord::Base

  validates :event_name, presence: true

end
