class Event < ActiveRecord::Base
  has_many :payload_requests

  validates :name, presence: true

  def self.list_events_by_frequency
    select("name").group("name").order("count_id DESC").count("id").keys
  end

end
