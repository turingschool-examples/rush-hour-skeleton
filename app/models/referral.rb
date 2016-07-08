class Referral < ActiveRecord::Base
    validates :address, presence: true
    has_many :urls

    def most_popular_referrers
      #   require "pry"; binding.pry
      # referrals.pluck(:address)
      
    end
end
