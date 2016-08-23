class RefactorVisitorResolutions < ActiveRecord::Migration
  def change
    remove_columns(:visitors, :resolution_height, :resolution_width)
  end
end
