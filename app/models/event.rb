class Event < ActiveRecord::Base
  has_many :payload_requests

  validates :name,  presence: true

  def self.event_most_recieved_to_least(payload_requests)
    events = payload_requests.order('event_id DESC').pluck(:event_id).uniq
    events.map do |event|
      Event.find(event).name
    end
  end

end
