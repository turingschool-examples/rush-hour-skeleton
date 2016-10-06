class CreatePayloadTable < ActiveRecord::Migration
  def change
    create_table :payloads do |t|

      t.text :url
      t.datetime :requestedAt
      t.integer :responedIn
      t.text :referredBy
      t.string :requestType
      t.string :eventName
      t.string :userAgent
      t.integer :resolutionWidth
      t.integer :resolutionHeight
      t.string :ip

      t.timestamp null: false
    end
  end
end
