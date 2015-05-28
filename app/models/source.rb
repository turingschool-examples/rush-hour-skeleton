class Source < ActiveRecord::Base
  validates :identifier, presence: true
  validates :root_url,   presence: true


end
# class Person < ActiveRecord::Base
#   validates :name, presence: true
# end
#
# Person.create(name: "John Doe").valid? # => true
# Person.create(name: nil).valid? # => false
