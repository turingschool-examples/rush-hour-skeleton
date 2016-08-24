class DropOperatingSystems < ActiveRecord::Migration
  def change
    drop_table :operating_systems
  end
end
