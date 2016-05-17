class CreateReferredBys < ActiveRecord::Migration
  def change
    create_table  :referred_bys do |t|
      t.text      :referred_by
    end
  end
end
