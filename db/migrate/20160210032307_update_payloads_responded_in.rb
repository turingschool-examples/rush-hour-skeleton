class UpdatePayloadsRespondedIn < ActiveRecord::Migration
  def change
    change_table :payloads do |t|
      t.remove :responded_in
      t.integer :responded_in
    end
  end
end
