class CreateResolutions < ActiveRecord::Migration
  def change
    create_table :resolutions do |t|
      t.integer :height
      t.integer :width

      t.timestamps null: false
    end
  end
end
