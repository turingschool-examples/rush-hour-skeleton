class CreateResolutionsTable < ActiveRecord::Migration
  def change
    create_table :resolutions do |t|
      t.text :width
      t.text :height
    end
  end
end
