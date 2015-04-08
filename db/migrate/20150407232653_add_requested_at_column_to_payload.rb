class AddRequestedAtColumnToPayload < ActiveRecord::Migration
  def change
    add_column :payloads, :requested_at, :string
  end
end
