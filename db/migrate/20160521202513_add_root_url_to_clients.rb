class AddRootUrlToClients < ActiveRecord::Migration
  def change
    add_column :clients, :root_url, :string
  end
end
