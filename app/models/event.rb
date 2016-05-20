class Event < ActiveRecord::Base
  has_many :payload_requests

  validates :name,  presence: true


  def event_most_recieved_to_least
    payload_requests.order('event DESC').pluck(:event)
  end

end
