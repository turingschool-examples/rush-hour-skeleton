class CreateUserAgentIdColumnAndResolutionsId < ActiveRecord::Migration
  def change
    add_column :payload_requests, :user_agent_id, :string
    add_column :payload_requests, :resolution_id, :string
  end
end
