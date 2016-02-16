class AddUniqueShaColumnToPayloadRequest < ActiveRecord::Migration
  def change
    add_column :payload_requests, :unique_sha, :string
  end
end
