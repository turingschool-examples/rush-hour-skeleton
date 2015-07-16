class AddReferredByColumnToPayloads < ActiveRecord::Migration
  def change
    add_column :payloads, :referred_by, :string
  end
end
