class Payload < ActiveRecord::Migration
  def change
    create_table :payloads do |t|
      t.text     :url
      t.datetime :requestedAt
      t.integer  :respondedIn
      t.text     :referredBy
      t.text     :requestType
      t.text     :eventName
      t.text     :userAgent
      t.integer  :resolutionWidth
      t.integer  :resolutionHeight
      t.integer  :ip
    end
  end
end
