class UserAgent < ActiveRecord::Base

    belongs_to :client
    belongs_to :url

    validates :ip_address, presence: true
    validates :client_id, presence: true
    validates :url_id, presence: true

  end
