class AddResolutionIdToPayloads < ActiveRecord::Migration
  def change
    add_reference :payloads, :resolution, index: true, foreign_key: true
  end
end
