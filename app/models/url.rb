class Url < ActiveRecord::Base
  has_one :source, :through => :visits
  has_many :visits
  validates :url, presence: true, uniqueness: true
  validates :source_id, presence: true
  validates :visits_count, presence: true
  validates :average_response_time, presence: true
end
