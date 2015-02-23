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

  def order_by_instances(items)
    items.each_with_object(Hash.new(0)) { |items,counts| counts[items] += 1 }.sort_by{ |k,v| v }.reverse.map {|x| "#{x[0]}, #{x[1]}"}
  end


  def browsers
    # This method will return an array of arrays with 2 elements in each array: 1) the browser, 2) the number of requests received from this browser
    browsers = self.payloads.collect(&:userAgent).map{|x| UserAgent.parse(x).browser}
    order_by_instances(browsers)
  end

  def operating_system
    oses = self.payloads.collect(&:userAgent).map{|x| UserAgent.parse(x).platform}
    order_by_instances(oses)
  end

  def screen_res
    res = self.payloads.map{|x| "#{x.resolutionWidth} x #{x.resolutionHeight}"}
    order_by_instances(res)
  end

  def response_times
  urls_and_times = self.payloads.map {|x| "#{x.urls.first.page},#{x.respondedIn}"}
  urls_pointing_to_times = urls_and_times.group_by {|(url, time)| url}
  urls_pointing_to_times.map { |x| "#{x.key}, #{x.values.sum/x.count}"}

  # example from stackoverflow to model after(?):
  #fruits.group_by {|(fruit, day)| fruit }.map {|fruit, match| [fruit, match.count] }

  # unfinished method approach:
  # self.payloads.map{|x| x.urls.first.page, x.respondedIn}.sort_by

  end

end
