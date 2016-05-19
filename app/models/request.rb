class Request < ActiveRecord::Base
  has_many :payload_requests

  validates :verb , presence: true, uniqueness: true


  def self.verbs_used
    pluck(:verb)
  end
end
