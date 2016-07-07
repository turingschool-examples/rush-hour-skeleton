class CreateResolutions < ActiveRecord::Migration
  def change
    create_table :resolutions do |t|
      t.integer :width
      t.integer :height

      t.timestamps null: false
    end
  end
end
