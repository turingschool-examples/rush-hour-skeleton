class CreateResolutions < ActiveRecord::Migration
  def change
    create_table :resolutions do |t|
      t.text :width
      t.text :height
      t.timestamps null: false
    end
  end
end
