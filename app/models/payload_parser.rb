class PayloadParser < ActiveRecord::Base
  def self.parse(data)
    address_id = Address.create(data[:url])
  end
end