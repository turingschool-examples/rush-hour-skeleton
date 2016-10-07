
class Agent < ActiveRecord::Base
  has_many :payload

  validates :browser, presence: true
  validates :operating_system, presence: true

end
