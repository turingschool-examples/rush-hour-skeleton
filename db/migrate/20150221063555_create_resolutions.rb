class CreateResolutions < ActiveRecord::Migration
  def change
    create_table :resolutions do |t|
      t.text :resolution_height
      t.text :resolution_width
    end
  end
end
