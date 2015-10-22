class Payload < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user_id

  def self.find_urls(user_id)
    urls = []
    urls = Payload.where(:user_id => user_id).pluck(:url)
    url_hash = urls.group_by do |url|
      url
    end
    visited_urls = url_hash.map do |key, value|
      url_hash[key] = value.count
    end
    sort_urls(url_hash)
  end

  def self.sort_urls(url_hash)
    url_hash.sort_by { |url, count| count}.reverse
  end
end
