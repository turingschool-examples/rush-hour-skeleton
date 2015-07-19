class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.text :path
      t.integer :site_id
      
      t.timestamps
    end
  end
end
