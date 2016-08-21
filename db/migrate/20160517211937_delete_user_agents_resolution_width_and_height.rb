class DeleteUserAgentsResolutionWidthAndHeight < ActiveRecord::Migration
  def change
    remove_column :payload_requests, :user_agent
    remove_column :payload_requests, :resolution_height
    remove_column :payload_requests, :resolution_width
  end
end
