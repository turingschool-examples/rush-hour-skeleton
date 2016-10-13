class CreateResolutions < ActiveRecord::Migration
  def change
    create_table :resolutions do |t|
      t.string  :height
      t.string  :width

      t.timestamps  null: false
    end 
  end
end
