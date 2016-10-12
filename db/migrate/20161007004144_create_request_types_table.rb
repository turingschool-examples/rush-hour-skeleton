class CreateRequestTypesTable < ActiveRecord::Migration
  def change
    create_table :request_types do |t|

      t.string :request_type

      t.timestamp null: false
    end
  end
end
