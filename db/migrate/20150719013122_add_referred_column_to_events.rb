class AddReferredColumnToEvents < ActiveRecord::Migration
  def change
    add_column :events, :referred_by, :text
  end
end
