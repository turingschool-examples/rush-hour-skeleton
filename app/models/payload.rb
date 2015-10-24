class Payload < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user_id

  def self.sort(hash)
    hash.sort_by { |key, count| key}.sort_by { |key, count| count }.reverse
  end

  def self.count(items)
    counted = items.group_by do |item|
      item
    end
    counted.map do |key, value|
      counted[key] = value.count
    end
    counted
  end

  def self.find_one(user_id, column_one)
    items= Payload.where(:user_id => user_id).pluck(column_one)
    counted = count(items)
    sort(counted)
  end

  def self.find_two(user_id, column_one, column_two)
    items= Payload.where(:user_id => user_id).pluck(column_one, column_two)
    counted = count(items)
    sort(counted)
  end

  def self.url_path(user_id, url)
    root = "http://" + user_id + ".com"
    path = url.gsub(root, "")
  end

  def self.url_link(user_id, url_count)
    path = Payload.url_path(user_id, url_count[0])
    full_url = "http://localhost:9393/sources/" + user_id + "/urls" + path
  end

  def self.event_link(user_id, url_count)
    path = Payload.url_path(user_id, url_count[0])
    full_url = "http://localhost:9393/sources/" + user_id + "/events/" + path
  end

  def self.active_record_browser(user_id, user_agent)
    agent_data= Payload.where(:user_id => user_id).pluck(user_agent)
    browser = []
    agent_data.each do |string|
      hash = UserAgent.parse(string)
      browser << hash.browser
    end
    counted = count(browser)
    sort(counted)
  end
end
