class ChangeResolutionsTableToText < ActiveRecord::Migration
  def change
    remove_column :resolutions, :height
    remove_column :resolutions, :width
    add_column :resolutions, :height, :text
    add_column :resolutions, :width, :text
  end
end
