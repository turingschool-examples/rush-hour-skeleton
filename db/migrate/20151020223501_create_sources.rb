class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.string :identifier
      t.string :root_url
    end
  end
end
