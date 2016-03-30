class DropClientTable < ActiveRecord::Migration
  def change
    drop_table :client
  end
end
