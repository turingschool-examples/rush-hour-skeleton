class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.text :path
    end
  end
end
