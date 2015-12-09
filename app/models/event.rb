class Event < ActiveRecord::Base

  belongs_to :client
  belongs_to :url

  validates :responded_in, presence: true
  validates :requested_at, presence: true
  validates :event_name, presence: true
  validates :client_id, presence: true
  validates :url_id, presence: true

end
