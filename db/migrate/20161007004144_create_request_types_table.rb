class CreateRequestTypesTable < ActiveRecord::Migration
  def change
    create_table :request_types do |t|

      t.string :requestType

      t.timestamp null: false
    end
  end
end
