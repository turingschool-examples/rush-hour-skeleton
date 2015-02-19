class CreatePayloadTable < ActiveRecord::Migration
  def change
    create_table :payloads do |t|
      t.text :url
      t.text :requestedAt
      t.integer :respondedIn
      t.text :referredBy
      t.text :requestType
      t.text :parameters
      t.text :eventName
      t.text :userAgent
      t.text :resolutionWidth
      t.text :resolutionHeight
      t.text :ip
  end
end
