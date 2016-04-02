class CreateRequestTypesTable < ActiveRecord::Migration
  def change
    create_table :request_types do |t|
      t.text :verb
    end
  end
end
