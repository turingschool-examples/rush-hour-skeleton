class User < ActiveRecord::Base
  has_many :sub_urls

  validates :root_url, presence: true, uniqueness: true
  validates :identifier, presence: true, uniqueness: true
end
