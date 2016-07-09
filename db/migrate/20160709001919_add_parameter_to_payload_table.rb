class AddParameterToPayloadTable < ActiveRecord::Migration
  def change
    add_column :payload_requests, :parameter_id, :integer
  end
end
