class AddPathToUrls < ActiveRecord::Migration
  def change
    add_column :urls, :path, :string
  end
end
