class UpdateVisits < ActiveRecord::Migration
  def change
    change_table :visits do |t|
      t.remove :url
      t.integer :url_id
    end
  end
end
