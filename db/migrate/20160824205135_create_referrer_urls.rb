class CreateReferrerUrls < ActiveRecord::Migration
  def change
    create_table :referrer_urls do |t|
      t.string :name

      t.timestamps null: false
    end

  end
end
