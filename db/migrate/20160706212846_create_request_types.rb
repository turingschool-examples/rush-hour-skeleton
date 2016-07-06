class CreateRequestTypes < ActiveRecord::Migration
  def change
    create_table :request_types do |t|
      t.text :verb

      t.timestamps null:false
    end
  end
end
