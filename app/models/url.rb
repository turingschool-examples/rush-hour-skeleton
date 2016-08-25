class Url < ActiveRecord::Base
  has_many :payload_requests
  validates :address, presence: true
  validates :address, uniqueness: true

  def self.most_to_least_requested_url
    group_by_url.to_a.map do |frequency_url_id|
      Url.find_by(:id => frequency_url_id[1]).address
    end
  end

  def self.group_by_url
    PayloadRequest.group('url_id').order("url_id desc").count
  end
end
