class Event < ActiveRecord::Base
  has_many :payload

  validates :event_name, presence: true

end
