class EventName < ActiveRecord::Base
  validates :event_name, presence: true

  has_many :payload_requests


  def self.most_to_least_requested_event_names
    ids = PayloadRequest.group(:event_name_id).count.sort_by {|k,v,| v}.reverse
    ids.map {|id| EventName.find(id[0]).event_name}
  end
end
