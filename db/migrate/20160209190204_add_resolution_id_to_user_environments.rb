class AddResolutionIdToUserEnvironments < ActiveRecord::Migration
  def change
    
      add_column :user_environments, :resolution_id, :integer
  end
end
