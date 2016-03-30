class Client < ActiveRecord::Base
  has_many :payload_requests

  validates :identifier, presence: true
  validates :root_url, presence: true

  #
  # def self.most_received_to_least
  #   group(:name).count.keys.reverse
  # end
end
