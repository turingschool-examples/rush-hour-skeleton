class DeleteBrowser < ActiveRecord::Migration
  def change
    remove_column :payloads, :browser
  end
end
