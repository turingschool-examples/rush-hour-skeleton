class RenameRequestTypeAndAddRequestTypeIdInPayloads < ActiveRecord::Migration
  def change
    rename_column :payloads, :request_type, :request_type_string
    add_column :payloads, :request_type_id, :integer
  end
end
