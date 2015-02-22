class CreateResolutionsTable < ActiveRecord::Migration
  def change
    create_table :resolutions do |t|
      t.integer :height
      t.integer :width
    end
  end
end
