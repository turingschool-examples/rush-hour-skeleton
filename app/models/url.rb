class TrafficSpy::URL < ActiveRecord::Base
  belongs_to :payload
  validates :url, uniqueness: true
end
