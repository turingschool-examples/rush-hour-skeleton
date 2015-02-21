class CreateRawDataColumnOnPayloadTable < ActiveRecord::Migration
  def change
    add_column :payloads, :raw_data, :string
  end
end
