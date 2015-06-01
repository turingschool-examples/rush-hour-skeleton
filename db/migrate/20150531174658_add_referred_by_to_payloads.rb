class AddReferredByToPayloads < ActiveRecord::Migration
  def change
    add_column :payloads, :referred_by, :text
  end
end
