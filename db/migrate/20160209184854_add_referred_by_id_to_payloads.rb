class AddReferredByIdToPayloads < ActiveRecord::Migration
  def change
    add_reference :payloads, :referred_by, index: true
  end
end
