class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string  :url_address

      t.timestamps null: false
    end
  end
end
