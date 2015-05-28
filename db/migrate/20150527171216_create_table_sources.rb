class CreateTableSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.text :identifier
      t.text :rooturl
    end
  end
end
