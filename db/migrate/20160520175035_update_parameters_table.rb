class UpdateParametersTable < ActiveRecord::Migration
  def change
    drop_table :request_at_times
  end
end
