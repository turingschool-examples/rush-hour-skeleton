class ChangeReferredByTitle < ActiveRecord::Migration
  def change
    rename_table(:references, :references)
    rename_column(:references, :reference, :reference)
    remove_column(:payload_requests, :reference_id, :integer)
    add_reference(:payload_requests, :reference, index: true)
  end
end
