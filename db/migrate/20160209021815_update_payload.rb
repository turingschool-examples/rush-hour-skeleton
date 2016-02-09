class UpdatePayload < ActiveRecord::Migration
  def change
    change_table :payloads do |t|
      t.string  :url
      t.string  :requestedAt
      t.string  :respondedIn
      t.string  :referredBy
      t.integer :id_requestType
      t.string  :eventName
      t.integer :id_browser
      t.integer :id_OS
      t.integer :id_screenResolution
      t.string  :ip
    end
  end
end
