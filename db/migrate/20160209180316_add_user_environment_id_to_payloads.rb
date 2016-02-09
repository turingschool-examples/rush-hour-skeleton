class AddUserEnvironmentIdToPayloads < ActiveRecord::Migration
  def change
    add_reference :payloads, :user_environment, index: true, foreign_key: true
  end
end
