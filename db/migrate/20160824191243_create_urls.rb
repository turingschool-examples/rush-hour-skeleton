class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :address
    end
  end
end
