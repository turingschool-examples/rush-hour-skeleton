class TrackedSite < ActiveRecord::Base
  has_many :payloads
end