class Source < ActiveRecord::Base
  has_many :visits, dependent: :destroy
  has_many :urls, :through => :visits, dependent: :destroy
  validates :identifier, presence: true, uniqueness: true
  validates :root_url, presence: true, uniqueness: true
end
