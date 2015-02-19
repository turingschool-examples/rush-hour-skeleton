class CreateSource < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.text :identifier
      t.text :rootUrl

      t.timestamps
    end
  end
end
