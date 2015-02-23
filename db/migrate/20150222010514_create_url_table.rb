class CreateUrlTable < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.text :page
    end
  end
end
