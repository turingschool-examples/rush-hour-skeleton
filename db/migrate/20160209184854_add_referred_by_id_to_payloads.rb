class AddReferredByIdToPayloads < ActiveRecord::Migration
  def change
    add_column :payloads, :referred_by_id, :integer
  end
end
