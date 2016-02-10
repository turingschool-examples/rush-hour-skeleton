class CreateUrl < ActiveRecord::Migration
  def change
    create_table :url do |t|
      t.string :path
      t.string :verb
    end
  end
end
