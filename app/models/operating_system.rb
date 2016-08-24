class OperatingSystem < ActiveRecord::Base
  validates :name, presence: true
end
