class CreatePayloads < ActiveRecord::Migration
  def change
    create_table :payloads do |t|
      t.string  :url
      t.string  :requestedAt
      t.integer :respondedIn
      t.string  :referredBy
      t.string  :requestType
      t.string  :eventName
      t.string  :userAgent
      t.string  :resolutionWidth
      t.string  :resolutionHeight
      t.string  :ip
    end
  end
end
