class Payload < ActiveRecord::Base

  belongs_to :client

end

# def self.url_requests
#   group(:path).order('count_id desc').count('id')
# end
