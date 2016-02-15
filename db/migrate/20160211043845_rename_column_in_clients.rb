class RenameColumnInClients < ActiveRecord::Migration
  def change
    def change
      rename_column :clients, :rootURL, :rootUrl
    end
  end
end
