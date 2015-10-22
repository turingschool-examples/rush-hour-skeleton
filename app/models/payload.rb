class Payload < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user_id

  def self.find_urls(user_id)
    urls = []
    urls = Payload.where(:user_id => user_id).pluck(:url)
    binding.pry
    urls.group_by
  end
end
