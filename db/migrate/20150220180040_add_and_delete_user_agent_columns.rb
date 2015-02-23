class AddAndDeleteUserAgentColumns < ActiveRecord::Migration
  def change
    add_column :agents, :browser, :text
    add_column :agents, :version, :text
    add_column :agents, :platform, :text
    remove_column :agents, :environment
  end
end
