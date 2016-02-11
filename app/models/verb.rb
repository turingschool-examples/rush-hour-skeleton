class Verb < ActiveRecord::Base
  validates :request_type, presence: true
end
