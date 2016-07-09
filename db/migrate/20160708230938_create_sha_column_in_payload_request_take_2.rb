class CreateShaColumnInPayloadRequestTake2 < ActiveRecord::Migration
  def change
    add_column :payload_requests, :sha, :binary
  end
end
