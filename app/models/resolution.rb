class Resolution < ActiveRecord::Base
  has_many :payload_requests

  validates :height, presence: true
  validates :width,  presence: true
  validates :height, uniqueness: { scope: :width }

  def self.resolutions_for_all
    res = joins(:payload_requests).group(:width, :height).count
    res.keys.each do |key|
      res["#{key[0]}x#{key[1]}"] = res.delete key
    end
    res
  end

end
