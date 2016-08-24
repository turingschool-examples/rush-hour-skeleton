class Browser < ActiveRecord::Base
  validates :name, presence: true
end
