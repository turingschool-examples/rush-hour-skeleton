class Sources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.string :identifier
      t.string :rootUrl
    end
  end
end
