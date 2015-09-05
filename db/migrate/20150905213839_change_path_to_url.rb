class ChangePathToUrl < ActiveRecord::Migration
  def change
    change_table :urls do |t|
      t.remove :path
      t.text :url
    end
  end
end
