class CreateResolutionsTable < ActiveRecord::Migration
  def change
    create_table :resolutions do |t|

      t.integer :resolution_width
      t.integer :resolution_height

      t.timestamp null: false
    end
  end
end
