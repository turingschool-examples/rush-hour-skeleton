class Url < ActiveRecord::Base
  has_many :payload_requests

  validates :address, presence: true

  def self.list_urls_by_frequency
    select("address").group("address").order("count_id DESC").count("id").keys
  end

end
