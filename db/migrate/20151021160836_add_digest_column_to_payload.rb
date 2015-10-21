class AddDigestColumnToPayload < ActiveRecord::Migration
  def change
    add_column :payloads, :digest, :text
  end
end
