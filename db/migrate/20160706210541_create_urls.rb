class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.text :root
      t.text :path

      t.timestamps null:false
    end
  end
end
