class AddUniqueShaForResolutionsAndUserSystems < ActiveRecord::Migration
  def change
    add_column :resolutions, :unique_sha, :string
    add_column :user_systems, :unique_sha, :string
  end
end
