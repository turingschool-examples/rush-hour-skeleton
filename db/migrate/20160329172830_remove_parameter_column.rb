class RemoveParameterColumn < ActiveRecord::Migration
  def change
    remove_column :payload_requests, :parameter_id
  end
end
