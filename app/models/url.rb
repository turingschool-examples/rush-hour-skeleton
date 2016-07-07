class URL < ActiveRecord::Base
  validates :address, :referred_by_id,
            presence: true

  

end
