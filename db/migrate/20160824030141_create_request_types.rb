class CreateRequestTypes < ActiveRecord::Migration
  def change
    create_table :request_types do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
