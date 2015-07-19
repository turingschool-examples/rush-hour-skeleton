class Registration < ActiveRecord::Base
  validates_uniqueness_of :identifier
  has_many :payloads
  has_many :events, through: :payloads

  def urls
    payloads.group(:url).count
  end

end
