class CombineResolutions < ActiveRecord::Migration
  def change
    remove_column :resolutions, :resolution_height
    remove_column :resolutions, :resolution_width
    add_column    :resolutions, :height_width, :string
  end
end
