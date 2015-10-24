class TrafficSpy::Agent < ActiveRecord::Base
  belongs_to :payload
  validates :agent, uniqueness: true
end
