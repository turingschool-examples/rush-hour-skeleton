class RemoveParametersColumnFromUrlRequestsTable < ActiveRecord::Migration
  def change
    remove_column :url_requests, :parameters
  end
end
