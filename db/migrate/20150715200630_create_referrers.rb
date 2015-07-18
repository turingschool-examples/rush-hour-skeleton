class CreateReferrers < ActiveRecord::Migration
  def change
    create_table :referrers do |t|
      t.text :path

      t.timestamps
    end
  end
end
