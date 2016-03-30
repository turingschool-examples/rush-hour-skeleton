class Event < ActiveRecord::Base
  has_many :payload_requests

  validates :name, presence: true

  def self.most_received_to_least
    group(:name).count.keys.reverse
  end
end
