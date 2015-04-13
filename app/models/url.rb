class Url < ActiveRecord::Base
  belongs_to :source

  has_many :payloads

end
