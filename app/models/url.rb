class Url < ActiveRecord::Base
  has_many :payloads
  # belongs_to :registration, through: :payloads
end
