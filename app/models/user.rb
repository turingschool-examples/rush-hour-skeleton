class User < ActiveRecord::Base
 validates :root_url, presence: true, uniqueness: true
 validates :identifier, presence: true, uniqueness: true
end
