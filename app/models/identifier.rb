class Identifier < ActiveRecord::Base
  validates_presence_of :name, :root_url
end
