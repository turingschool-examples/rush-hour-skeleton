class Renameroot_url < ActiveRecord::Migration
  def change
    rename_column :clients, :root_url, :root_url
  end
end
