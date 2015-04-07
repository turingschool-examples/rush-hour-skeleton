class Client < ActiveRecord::Base
  validates :identifier, presence: true, uniqueness: true
  validates :rootUrl, presence: true
end