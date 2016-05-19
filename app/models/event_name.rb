class EventName < ActiveRecord::Base
  validates "event_name", presence: true

  has_many :payload_requests

  def self.most_to_least_requested_event_names
    ids = PayloadRequest.group(:event_name_id).count.keys
    ids.map {|id| EventName.find(id).event_name}
  end
end
