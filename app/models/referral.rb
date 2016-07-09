class Referral < ActiveRecord::Base
    validates :address, presence: true, uniqueness: true
    has_many :payload_requests

    def most_popular_referrers
      #   require "pry"; binding.pry
      # referrals.pluck(:address)

    end
end
