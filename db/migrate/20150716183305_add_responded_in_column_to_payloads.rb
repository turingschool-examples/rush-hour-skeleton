class AddRespondedInColumnToPayloads < ActiveRecord::Migration
  def change
    add_column :payloads, :responded_in, :integer
  end
end
