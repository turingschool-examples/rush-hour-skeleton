class Site < ActiveRecord::Base
  validates :identifier, presence: true, uniqueness: true
  validates_presence_of :root_url

  has_many :urls
  has_many :payloads, through: :urls
  has_many :browsers, through: :payloads
  has_many :platforms, through: :payloads
  has_many :events, through: :payloads
  has_many :request_types, through: :payloads
  has_many :referrers, through: :payloads

end
