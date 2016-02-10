class DropOs < ActiveRecord::Migration
  def change
    drop_table(:os)
  end
end
