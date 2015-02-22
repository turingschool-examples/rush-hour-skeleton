class ChangeRespondedInToIntger < ActiveRecord::Migration
  def change
    remove_column :payloads, :responded_in
    add_column :payloads, :responded_in, :integer
  end
end
