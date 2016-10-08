class Client < ActiveRecord::Base
  has_many :payload
  has_many :agent, through: :payload
  has_many :event, through: :payload
  has_many :resolution, through: :payload
  has_many :url, through: :payload
  has_many :ip, through: :payload
  has_many :request_type, through: :payload
  has_many :referred_by, through: :payload

  validates :identifer, presence: true
  validates :identifer, uniqueness: true
  validates :root_url, presence: true

end
