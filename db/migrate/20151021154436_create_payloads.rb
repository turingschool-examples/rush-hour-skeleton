class CreatePayloads < ActiveRecord::Migration
  def change
    create_table :payloads do |t|
      t.string :url
      t.timestamp :requestedAt
      t.string :respondedIn
      t.string :referredBy
      t.string :requestType
      t.string :parameters
      t.string :eventName
      t.string :userAgent
      t.string :resolutionWidth
      t.string :resolutionHeight
      t.string :ip
    end
  end
end
