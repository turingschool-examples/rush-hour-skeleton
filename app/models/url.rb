class Url < ActiveRecord::Base
  has_many :payload_requests
  has_many :referrers, through: :payload_requests
  has_many :request_types, through: :payload_requests
  has_many :user_agents, through: :payload_requests

  validates :address, presence: true

  def self.most_to_least_requested
    group(:address).count.keys.reverse
  end

  def self.list_all_verbs_given_url
    # joins{request_types: :user_agents}.where(request_types.user_agents: {id: 1})
    # request_types.pluck(:verb)
    RequestType.where(id: PayloadRequest.where(url_id: Url.where(address: "http://jumpstartlab.com").pluck(:id)).pluck(:request_type_id)).pluck(:verb).uniq
  end

  def list_top_three_referrers
    referrers.group(:address).order(count: :desc).count.keys
  end #reset the test on this one


  #def list_top_three_user_agent
  #  user_agents.group(:browser, :platform).order#I'm not done here
  #  #SCIENCE IT!!!!
  #end

end
