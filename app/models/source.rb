module TrafficSpy
  class Source < ActiveRecord::Base
    has_many  :payloads
    validates :root_url,   presence: true
    validates :identifier, presence: true,
                         uniqueness: { scope: :root_url,
                                     message: "Identifier already exists" }

    # def self.duplicate_identifier
    #     status 403
    #     body "Identifier already exists"
    # end
  end
end
