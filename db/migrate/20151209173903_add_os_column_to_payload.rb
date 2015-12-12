class AddOsColumnToPayload < ActiveRecord::Migration
  def change
    add_column :payloads, :os, :string
  end
end
