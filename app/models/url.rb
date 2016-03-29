class Url < ActiveRecord::Base
  has_many(:payload_requests)
  validates :root_url, presence: true
  validates :path,     presence: true

  def self.most_to_least_requested
    self.all.sort_by { |url| url.payload_requests.count}.reverse.map {|url| url.full_path }
  end




  def full_path
    [self.root_url, self.path].join('')
  end
end
