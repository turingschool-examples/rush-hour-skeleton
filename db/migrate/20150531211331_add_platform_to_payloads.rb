class AddPlatformToPayloads < ActiveRecord::Migration
  def change
    add_column :payloads, :platform, :text
  end
end
