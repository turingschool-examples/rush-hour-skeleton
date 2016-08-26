class Client < ActiveRecord::Base
   has_many :payload_requests

   validates :rootUrl, presence: true
   validates :identifier, presence: true
end
