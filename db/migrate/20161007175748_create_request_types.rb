class CreateRequestTypes < ActiveRecord::Migration
  def change
    create_table :request_types do |t|
      t.text :http_verb
      t.timestamps null: false
    end
  end
end
