class Referral < ActiveRecord::Base
  validates :root_url, presence: true
  validates :path,     presence: true

  has_many :payload_requests

  def full_path
    [self.root_url, self.path].join('')
  end
end
