class Referrer < ActiveRecord::Base
  has_many :payload_requests
  has_many :urls, through: :payload_requests
  has_many :clients, through: :payload_requests

  validates :name, presence: true

  def self.rank_by_count
    group(:name).count
  end
end
