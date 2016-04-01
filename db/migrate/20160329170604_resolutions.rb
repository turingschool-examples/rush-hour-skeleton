class Resolutions < ActiveRecord::Migration
  def change
    create_table :resolutions do |t|
      t.string  :width
      t.string  :height

      t.timestamps null: false
    end
  end
end
