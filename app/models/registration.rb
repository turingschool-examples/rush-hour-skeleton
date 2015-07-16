class Registration < ActiveRecord::Base
  validates_uniqueness_of :identifier
  has_many :payloads


  def urls
    Url.all.map do |url_object|
      url_object[:url]
    end
  end

end
