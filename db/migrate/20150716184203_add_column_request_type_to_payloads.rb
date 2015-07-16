class AddColumnRequestTypeToPayloads < ActiveRecord::Migration
  def change
    add_column :payloads, :request_type, :string
  end
end
