class Payload < ActiveRecord::Base
  validates_presence_of :url, :sha
  validates :sha, uniqueness: true
end
