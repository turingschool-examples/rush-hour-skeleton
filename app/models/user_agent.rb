class UserAgent < ActiveRecord::Base

    belongs_to :client
    belongs_to :url

    validates :web_browser, presence: true
    validates :operating_system, presence: true
    validates :resolution_width, presence: true
    validates :resolution_height, presence: true
    validates :ip_address, presence: true
    validates :client_id, presence: true
    validates :url_id, presence: true

    def self.web_browser_breakdown
      
    end


  end
