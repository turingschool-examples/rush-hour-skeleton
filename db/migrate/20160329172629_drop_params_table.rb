class DropParamsTable < ActiveRecord::Migration
  def change
    drop_table :parameters
  end
end
