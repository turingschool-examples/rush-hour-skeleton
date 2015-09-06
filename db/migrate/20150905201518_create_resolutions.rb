class CreateResolutions < ActiveRecord::Migration
  def change
    create_table :resolutions do |t|
      t.string :resolution_height
      t.string :resolution_width

      t.timestamps null: false
    end
  end
end
