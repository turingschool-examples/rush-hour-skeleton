class RenameUrlColumns < ActiveRecord::Migration
  def change
    rename_column :urls, :sub_url, :url
    rename_column :urls, :user_id, :source_id
  end
end
