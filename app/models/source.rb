module TrafficSpy
class Source < ActiveRecord::Base
  # attr_reader :identifier, :rootUrl

  validates_presence_of :identifier, :rootUrl
  validates :identifier, uniqueness: true
  # validates :title, presence: true, length whatever blah blah  synonymous for this purpose

end
end
