class Event < ActiveRecord::Base
  has_many :payloads

  validates :name, presence: true

  def self.most_frequent_event_name
    self.joins(:payloads).group("events.name").order(count: :desc).count
  end
end
