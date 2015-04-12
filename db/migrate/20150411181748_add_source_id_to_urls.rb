class AddSourceIdToUrls < ActiveRecord::Migration
  def change
    add_column :urls, :source_id, :integer
  end
end
