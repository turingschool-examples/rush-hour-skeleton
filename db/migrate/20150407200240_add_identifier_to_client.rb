class AddIdentifierToClient < ActiveRecord::Migration
  def change
    rename_column :clients, :name, :identifier
  end
end
