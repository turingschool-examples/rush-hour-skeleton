class Url < ActiveRecord::Base
  belongs_to :payload
  # belongs_to :registration, through: :payloads
end
