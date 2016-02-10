class ChangePayloadFromBrowserAndOsToUserAgent < ActiveRecord::Migration
  def change
    change_table :payloads do |t|
      t.remove :os_id
      t.remove :browser_id
      t.integer :user_agent_id
    end
  end
end
