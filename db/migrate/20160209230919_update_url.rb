class UpdateUrl < ActiveRecord::Migration
  def change
    change_table :url do |t|
      t.string :route
    end
  end
end
