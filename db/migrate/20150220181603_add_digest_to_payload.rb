class AddDigestToPayload < ActiveRecord::Migration
  def change
    add_column :payloads, :digest, :text
  end

end
