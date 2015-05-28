class Client < ActiveRecord::Base
  validates_presence_of :identifier, :root_url
  validates :identifier, uniqueness: { case_sensitive: false }
end

