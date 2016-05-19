class ReferredBy < ActiveRecord::Base
  has_many :payload_requests

  validates :name, presence: true

  def self.three_most_popular_referrers
    select("name").group("name").order("count_id DESC").limit(3).count("id").keys
  end
end
