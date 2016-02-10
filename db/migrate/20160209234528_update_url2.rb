class UpdateUrl2 < ActiveRecord::Migration
  def change
    change_table :url do |t|
      t.remove :path
      t.remove :verb
    end
  end
end
