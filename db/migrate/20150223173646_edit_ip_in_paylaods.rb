class EditIpInPaylaods < ActiveRecord::Migration
  def change
    remove_column :payloads, :ip_id
    remove_column :payloads, :resolutionWidth
    remove_column :payloads, :resolutionHeight
    add_column :payloads, :resolutionWidth, :text
    add_column :payloads, :resolutionHeight, :text
  end
end
