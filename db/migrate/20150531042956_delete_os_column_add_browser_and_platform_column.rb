class DeleteOsColumnAddBrowserAndPlatformColumn < ActiveRecord::Migration
  def change
    remove_column :payloads, :os
    add_column :payloads, :browser, :string
    add_column :payloads, :platform, :string
  end
end
