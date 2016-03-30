class Url < ActiveRecord::Base
  has_many(:payload_requests)

  validates :root_url, presence: true
  validates :path,     presence: true

  def self.most_to_least_requested
    # look for alternative?
    self.all.sort_by { |url| url.payload_requests.count}.reverse.map {|url| url.full_path }
  end

  def full_path
    [self.root_url, self.path].join('')
  end

  def self.max_response_time(url)
    find_or_initialize_by(root_url: url).payload_requests.maximum("response_time")
  end

  def self.min_response_time(url)
    find_or_initialize_by(root_url: url).payload_requests.minimum("response_time")
  end

  def self.average_response_time(url)
    find_or_initialize_by(root_url: url).payload_requests.average("response_time").to_i
  end

  def self.find_verbs_for_a_url(url)
    find_or_initialize_by(root_url: url).payload_requests.pluck
  end
end
