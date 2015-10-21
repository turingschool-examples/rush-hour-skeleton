class AddSourcesIdToPayload < ActiveRecord::Migration
  def change
    add_column :payloads, :sources_id, :integer
  end
end
