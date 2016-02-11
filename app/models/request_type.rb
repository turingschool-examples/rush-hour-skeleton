require 'pry'
class RequestType < ActiveRecord::Base
  has_many :payloads

  validates :verb, presence: true, uniqueness: true

  def self.list_distinct_verbs
    self.distinct(:verb).pluck(:verb)
  end

end
