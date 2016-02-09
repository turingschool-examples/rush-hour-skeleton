class ReferredBys < ActiveRecord::Migration
  def change
    create_table :referred_bys do |t|
      t.string :url_address
    end
  end
end
