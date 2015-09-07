class DropShas < ActiveRecord::Migration
  def change
    drop_table :shas
  end
end
