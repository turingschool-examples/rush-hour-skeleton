class Agent < ActiveRecord::Base

  validates :browser, presence: true
  validates :operating_system, presence: true

end
