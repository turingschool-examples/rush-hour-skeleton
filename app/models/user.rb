class User < ActiveRecord::Base

	has_many :payloads

	validates :identifier, presence: true, uniqueness: true
	validates :rootUrl, presence: true


  def ordered_urls
    # 1. find all urls for user
    # 2. order them from most to least visited.
		binding.pry
    urls = self.payloads.collect(&:urls).flatten.collect(&:page)
    order_by_instances(urls)
  end

  def order_by_instances(urls)
    urls.each_with_object(Hash.new(0)) { |urls,counts| counts[urls] += 1 }.sort_by{ |k,v| v }.collect(&:first)
  end

end
