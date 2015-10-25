class AddIpIdToPayloads < ActiveRecord::Migration
  def change
    add_column :payloads, :ip_id, :integer
  end
end
