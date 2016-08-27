class RenameUrlsToTargetUrls < ActiveRecord::Migration
  def change
    rename_table :urls, :target_urls
  end
end
