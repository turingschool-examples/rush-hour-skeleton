class CreateReferrerTable < ActiveRecord::Migration
  def change
    create_table :referrers do |t|
      t.text :name
    end
  end
end
