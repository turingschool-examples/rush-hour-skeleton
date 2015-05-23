class RemoveTimestamps < ActiveRecord::Migration
  def change
    remove_column :payloads, :created_at 
    remove_column :payloads, :updated_at 
  end
end
