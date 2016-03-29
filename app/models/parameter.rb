class Parameter < ActiveRecord::Base
  validates :params, presence: true
end
