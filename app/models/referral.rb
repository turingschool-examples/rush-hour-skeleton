class Referral < ActiveRecord::Base
    validates :address, presence: true, uniqueness: true
    has_many :urls
end
