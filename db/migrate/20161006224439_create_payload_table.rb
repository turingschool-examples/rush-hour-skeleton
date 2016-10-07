class CreatePayloadTable < ActiveRecord::Migration
  def change
    create_table :payloads do |t|

      t.text :url
      t.datetime :requestedAt
      t.integer :respondedIn
      t.text :referredBy
      t.integer :request_type_id
      t.string :eventName
      t.string :userAgent
      t.integer :resolutionWidth
      t.integer :resolutionHeight
      t.string :ip

      t.timestamp null: false
    end
  end
end
