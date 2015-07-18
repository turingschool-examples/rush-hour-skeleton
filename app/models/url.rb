class Url < ActiveRecord::Base
  validates :path, presence: true

  has_many :payloads
  belongs_to :site

  def relative_path
    @relative_path = self.path.clone
    @relative_path.slice!(self.site.root_url)
    @relative_path[1..-1]
  end
end
