class CreateResolutionTables < ActiveRecord::Migration
  def change
    create_table  :resolutions do |t|
      t.text      :resolution_width
      t.text      :resolution_height
    end
  end
end
