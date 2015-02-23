class Url < ActiveRecord::Base
  has_many :payloads

  def self.longest_response_time(webpage)
    Url.find_by(address: webpage).payloads.maximum(:responded_in)
  end

  def self.shortest_response_time(webpage)
    Url.find_by(address: webpage).payloads.minimum(:responded_in)
  end

  def self.average_response_time(webpage)
    Url.find_by(address: webpage).payloads.average(:responded_in)
  end
end
