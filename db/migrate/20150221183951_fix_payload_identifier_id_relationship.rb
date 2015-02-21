class FixPayloadIdentifierIdRelationship < ActiveRecord::Migration
  def change
    remove_column :identifiers, :payload_id
    add_column :payloads, :identifier_id, :integer
  end
end
