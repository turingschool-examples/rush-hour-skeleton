class Payload < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user_id

  def self.sort(hash)
    hash.sort_by { |key, count| count}.reverse
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
end
