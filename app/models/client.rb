class Client < ActiveRecord::Base
   has_many :payload_requests

   validates :root_url, presence: true
   validates :identifier, presence: true

   validates :root_url, uniqueness: {scope: :identifier}
   validates :identifier, uniqueness: {scope: :root_url}
end
