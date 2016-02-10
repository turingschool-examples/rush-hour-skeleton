class UpdateUrl2 < ActiveRecord::Migration
  def change
    change_table :url do |t|
      t.remove :path
      t.remove :root
    end
  end
end
