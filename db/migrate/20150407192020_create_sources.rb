class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.string :identifier
      t.string :rootURL
    end
  end
end
