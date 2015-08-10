class AddRegistrationIdToPayloads < ActiveRecord::Migration
  def change
    add_column :payloads, :registration_id, :integer
  end
end
