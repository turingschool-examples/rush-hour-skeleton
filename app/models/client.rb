class Client < ActiveRecord::Base
   has_many :payload_requests
   has_many :urls, through: :payload_requests
   has_many :system_informations, through: :payload_requests
   has_many :resolutions, through: :payload_requests
   has_many :request_types, through: :payload_requests


   validates :root_url, presence: true
   validates :identifier, presence: true

   validates :root_url, uniqueness: {scope: :identifier}
   validates :identifier, uniqueness: {scope: :root_url}
   
   def average_response_time
    payload_requests.average(:responded_in)
   end
   
   def max_response_time
     payload_requests.maximum(:responded_in)
     
   end
   
   def min_response_time
     payload_requests.minimum(:responded_in)
   end
   
   def most_frequent_request_type
     request_types.group(:http_verb).count
   end
   
   def list_all_verbs
     requests = request_types.group(:http_verb).count
     verbs = requests.collect do |verb, count|
       verb
     end
     verbs
   end
   
   def sorted_urls_by_request_count
     url_count = urls.group(:web_address).count
     sorted_urls = url_count.sort_by do |url, count|
       count
     end.reverse
     sorted_urls
   end
   
   def browser_count
     system_informations.group(:browser).count
   end
   
   def operating_system_count
    system_informations.group(:operating_system).count
   end
   
   def screen_resolutions
     resolutions.group(:height, :width).count
   end
end
