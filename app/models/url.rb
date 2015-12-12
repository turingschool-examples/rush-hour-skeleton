class Url < ActiveRecord::Base
  has_many :requests
  validates :path, presence:true, uniqueness: true
end
