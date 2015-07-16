class CreateScreenResolutionsTable < ActiveRecord::Migration
  def change
    create_table :screen_resolutions do |t|
      t.integer :width
      t.integer :height
      t.timestamps
    end

  end
end
