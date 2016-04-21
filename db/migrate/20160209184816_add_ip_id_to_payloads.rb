class AddIpIdToPayloads < ActiveRecord::Migration
  def change
    add_reference :payloads, :ip, index: true, foreign_key: true
  end
end
