class TargetURL < ActiveRecord::Base
  validates :name, presence: true
end
