class Source < ActiveRecord::Base
  validates :identifier, presence: true
  validates :rooturl, presence: true
end