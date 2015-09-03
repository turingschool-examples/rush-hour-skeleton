class Visit < ActiveRecord::Base
  validates :sha_identifier, presence: true, uniqueness: true
end