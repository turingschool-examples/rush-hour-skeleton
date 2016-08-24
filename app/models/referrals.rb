class Resolutions < ActiveRecord::Base
  validates :referred_by, presence: true
end