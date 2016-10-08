class Agent < ActiveRecord::Base
  has_many :payload
  # has_many :client, through: :payload
  # belongs_to :client


  validates :browser, presence: true
  validates :operating_system, presence: true

end
