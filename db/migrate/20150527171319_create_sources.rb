class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.text :identifier
      t.text :rootURL

      t.timestamps null: false
    end
  end
end
