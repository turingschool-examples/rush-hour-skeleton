class Referral < ActiveRecord::Base
    validates :address, presence: true
    has_many :urls
end
