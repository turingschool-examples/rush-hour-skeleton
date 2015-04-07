class Identifier < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :root_url, presence: true
end
