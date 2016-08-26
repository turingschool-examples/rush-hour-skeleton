class TargetUrl < ActiveRecord::Base
  has_many :payload_requests

  validates :name, presence: true
  validates :name, uniqueness: true

  def most_to_least_requested
    urls_requested = joins(:payload_requests).group(:name).count
    urls_requested.sort_by{ |k,v| v }.map(&:first).reverse
  end
end
