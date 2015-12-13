class Event < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_many :requests

  def requests_for_given_app(app_id)
    requests.where(application_id: app_id)
  end

  def array_of_hours(app_id)
    requests_for_given_app(app_id).pluck(:timestamp).map { |t| t.hour }
  end

  def sorted_list_by_hour(app_id)
    group = Hash(array_of_hours(app_id).group_by { |x| x} )
    freq = group.map { |num, arr| [num, arr.size] }.to_h
    (0..23).to_a.map do |n|
      freq[n]? value = freq[n] : value = 0
      Hash( n => value )
    end
  end
end