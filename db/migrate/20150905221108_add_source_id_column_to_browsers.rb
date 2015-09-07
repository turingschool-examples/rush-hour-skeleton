class AddSourceIdColumnToBrowsers < ActiveRecord::Migration
  def change
    add_column :browsers, :source_id, :integer
  end
end
