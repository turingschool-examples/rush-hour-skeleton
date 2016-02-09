class AddUserEnvironmentIdToPayloads < ActiveRecord::Migration
  def change
    add_column :payloads, :user_environment_id, :integer
  end
end
