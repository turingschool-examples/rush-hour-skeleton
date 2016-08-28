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
end
