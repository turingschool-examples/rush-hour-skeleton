class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :name
    end
  end
end
