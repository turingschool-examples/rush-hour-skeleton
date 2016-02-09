class AddUrlIdToPayloads < ActiveRecord::Migration
  def change
    add_reference :payloads, :url, index: true, foreign_key: true
  end
end
