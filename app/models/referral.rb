class Referral < ActiveRecord::Base
  validates :source, presence: true

  has_many :payloads

  def self.three_most_popular
    count = group(:source).count(:id)
    sorted_referrals = count.sort_by { |referrer, count|  count}.reverse
    sorted_referrals.first(3).map { |referrer|  referrer.first }
  end
end
