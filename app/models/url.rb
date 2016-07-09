class Url < ActiveRecord::Base
   validates :root, presence: true
   validates :path, presence: true, uniqueness: true
   has_many :payload_requests

   has_many :request_types, through: :payload_requests
  # has_many :referrals, through: :payload_requests
  # has_many :user_agent_devices, through: :payload_requests
  # need to find a way to track the data and increment it

  def verbs
    #not working yet
    RequestType.distinct.pluck(:verb).join(' , ')
    # request_types.pluck(:verb).uniq
    # RequestType.group(:verb).count(:id)
  end

end
