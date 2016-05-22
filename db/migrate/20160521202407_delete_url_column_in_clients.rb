class DeleteUrlColumnInClients < ActiveRecord::Migration
  def change
    remove_column :clients, :url 
  end
end
