class AddReferIdToPayloads < ActiveRecord::Migration
  def change
    add_reference :payloads, :refer, index: true, foreign_key: true 
  end
end
