class RenameSubUrlsToUrls < ActiveRecord::Migration
  def change
    rename_table :sub_urls, :urls
  end
end
