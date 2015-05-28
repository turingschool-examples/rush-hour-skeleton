module TrafficSpy
  class Source < ActiveRecord::Base
    validates :root_url,   presence: true
    validates :identifier, presence: true,
                         uniqueness: { scope: :root_url,
                                     message: "Identifier already exists" }
  end
end
