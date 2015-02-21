class Source < ActiveRecord::Base
  validates :rootUrl, :identifier, uniqueness: true, presence: true

end
