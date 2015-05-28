class Source < ActiveRecord::Base
  validates_presence_of :root_url
  validates :identifier, uniqueness: true, presence: true
end
