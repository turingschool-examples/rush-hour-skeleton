class AddColumnResponseTimeToPayloads < ActiveRecord::Migration
  def change
    add_column :payloads, :response_time, :integer
  end
end