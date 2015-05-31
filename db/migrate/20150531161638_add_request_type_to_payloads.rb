class AddRequestTypeToPayloads < ActiveRecord::Migration
  def change
    add_column :payloads, :request_type, :text
  end
end
