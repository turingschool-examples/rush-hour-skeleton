class Client < ActiveRecord::Base
   has_many :payload_requests

   validates :rootUrl, presence: true
end
