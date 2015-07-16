require 'digest/sha1'

class Payload < ActiveRecord::Base
  belongs_to :url
  belongs_to :event
  belongs_to :referrer
  belongs_to :browser
  belongs_to :platform
  belongs_to :request_type

  def self.create_sha(payload)
    if payload != nil
      Digest::SHA1.hexdigest(payload)
    end
  end
end
