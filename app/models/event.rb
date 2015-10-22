class TrafficSpy::Event < ActiveRecord::Base
  belongs_to :payload
  validates :event_name, uniqueness: true
end
