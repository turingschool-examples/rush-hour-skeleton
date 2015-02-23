class User < ActiveRecord::Base

	has_many :payloads

	validates :identifier, presence: true, uniqueness: true
	validates :rootUrl, presence: true


  def ordered_urls
    # 1. find all urls for user
    # 2. order them from most to least visited.
    urls = self.payloads.collect(&:urls).flatten.collect(&:page)
    order_by_instances(urls)
  end

  def order_by_instances(urls)
    urls.each_with_object(Hash.new(0)) { |urls,counts| counts[urls] += 1 }.sort_by{ |_k,v| v }.reverse.collect(&:first)
  end


  def browsers
    # This method will return an array of arrays with 3 elements in each array: 1) the browser, 2) the number of requests received from this browser, and 3) percentage of total requests received from this browser.


  end

  def operating_system
    # This method will return an array of arrays with 3 elements in each array: 1) the operating system, 2) the number of requests received from this operating system, and 3) percentage of total requests received from this operating system.

  end



end
