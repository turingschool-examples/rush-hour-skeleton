class Payload < ActiveRecord::Base
  belongs_to :url
  belongs_to :registration
end
