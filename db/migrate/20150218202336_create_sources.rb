class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.text :identifier
      t.text :root_url

      t.timestamps
    end
  end
end
