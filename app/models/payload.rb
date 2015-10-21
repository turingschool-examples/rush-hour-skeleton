class Payload < ActiveRecord::Base
  # validates_presence_of
  validates_uniqueness_of :digest

  belongs_to :sources
end
