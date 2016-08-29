class CreateResolutions < ActiveRecord::Migration
  def change
    create_table :resolutions do |t|
      t.text :height
      t.text :width

      t.timestamps null:false
    end
  end
end
