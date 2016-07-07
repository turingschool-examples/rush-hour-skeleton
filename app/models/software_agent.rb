class SoftwareAgent < ActiveRecord::Base
  validates :brower, :version, :platform, presence: true
end
