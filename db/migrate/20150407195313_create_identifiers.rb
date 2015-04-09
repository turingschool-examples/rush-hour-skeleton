class CreateIdentifiers < ActiveRecord::Migration
  def change
    create_table :identifiers do |t|
      t.string  :title
      t.string  :root_url
    end
  end
end
