class RemoveColumnsFromEvents < ActiveRecord::Migration
  def change
    change_table :events do |t|
      t.remove :responded_in, :referred_by
    end
  end
end
