class AddParametersTable < ActiveRecord::Migration
  def change
    create_table :request_at_times do |t|
      t.string :list
    end
  end
end
