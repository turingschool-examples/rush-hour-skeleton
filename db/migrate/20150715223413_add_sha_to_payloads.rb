class AddShaToPayloads < ActiveRecord::Migration
  def change
    add_column :payloads, :sha, :text
  end
end
