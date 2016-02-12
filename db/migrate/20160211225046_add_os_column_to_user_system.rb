class AddOsColumnToUserSystem < ActiveRecord::Migration
  def change
    rename_column :user_systems, :browser, :browser_type
    add_column :user_systems, :operating_system, :string
  end
end
