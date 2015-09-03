class Sha < ActiveRecord::Base
  validates :sha, presence: true, uniqueness: true
end