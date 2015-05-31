class DeleteOsColumnAddBrowserAndPlatformColumn < ActiveRecord::Migration
  def change
    add_column :payloads, :browser, :string
    add_column :payloads, :platform, :string
  end
end
