class EventName < ActiveRecord::Base
  has_many :payloads
  validates :name, presence: true, uniqueness: true

  def self.sort_payloads_by_requests
    self.all.sort_by do |event_name|
      -event_name.payloads.count
    end.map(&:name)
  end
end
