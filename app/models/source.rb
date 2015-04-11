class Source < ActiveRecord::Base
  validates :identifier, presence: true, uniqueness: true
  validates :root_url, presence: true

end
